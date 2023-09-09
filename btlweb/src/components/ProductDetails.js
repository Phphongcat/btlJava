
import { useContext, useEffect, useState } from "react";
import { Button, Col, Form, Image, ListGroup, Row } from "react-bootstrap";
import Moment from "react-moment";
import cookie from "react-cookies";
import { Link, useParams, Navigate } from "react-router-dom";
import { MyUserContext, MyCartContext } from "../App";
import Apis, { authApi, endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";

const ProductDetails = () => {
    const [user, ] = useContext(MyUserContext);
    const {productId} = useParams();
    const [product, setProduct] = useState(null);
    const [, cartDispatch] = useContext(MyCartContext);
    const [comments, setComments] = useState(null);
    const [content, setContent] = useState();

    useEffect(() => {
        const loadProduct = async () => {
            let {data} = await Apis.get(endpoints['details'](productId));
            setProduct(data); 
        }

        const loadComments = async () => {
            let {data} = await Apis.get(endpoints['comments'](productId));
            setComments(data);
        }

        loadProduct();
        loadComments();
    }, []);

    const order = (product) => {
        cartDispatch({
            "type": "inc",
            "payload": 1
        });
        
        // lưu vào cookies
        let cart = cookie.load("cart") || null;
        if (cart == null)
            cart = {};
        
        if (product.id in cart) { // sản phẩm có trong giỏ
            cart[product.id]["quantity"] += 1;
        } else { // sản phẩm chưa có trong giỏ
            cart[product.id] = {
                "id": product.id,
                "name": product.name,
                "quantity": 1,
                "unitPrice": product.price
            }
        }

        cookie.save("cart", cart);

        console.info(cart);
    }

    const addComment = () => {
        const process = async () => {
            let {data} = await authApi().post(endpoints['add-comment'], {
                "content": content, 
                "product": product.id
            });

            setComments([...comments, data]);
        }

        process();
    }
    
    if (product === null || comments === null)
        return <MySpinner /> ;

    let url = `/login?next=/products/${productId}`;
    return <>
        <h1 className="text-center text-info mt-2">CHI TIẾT SẢN PHẨM</h1>
        <Row>
            <Col md={5} xs={6}>
                <Image src={product.image} rounded fluid />
            </Col>
            <Col md={5} xs={6}>
                <h2 className="text-danger">{product.name}</h2>
                <p>{product.description}</p>
                <h3>{product.price} VNĐ</h3>
                <h3>Cửa hàng: {product.shopId.name}</h3>
                <Button variant="success" onClick={() => order(product)}>Đặt hàng</Button>
            </Col>
        </Row>
        <hr />
        

        {user===null?<p>Vui lòng <Link to={url}>đăng nhập</Link> để bình luận! </p>:<>
        <Form.Control as="textarea" aria-label="With textarea" value={content} onChange={e => setContent(e.target.value)} placeholder="Nội dung bình luận" />
        <Button onClick={addComment} className="mt-2" variant="info">Bình luận</Button>
        </>}
        <hr />
        <ListGroup>
            {comments.map(c => <ListGroup.Item id={c.id}>
                        {c.user.username} - {c.content} - <Moment locale="vi" fromNow>{c.createdDate}</Moment>
                    </ListGroup.Item>)
            }
        </ListGroup>
    </>
}

export default ProductDetails;