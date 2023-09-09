import { useEffect, useState } from "react"
import { Card, Col, Row, Alert, Button } from "react-bootstrap";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";
import { useParams, useNavigate } from "react-router-dom";
import cookie from "react-cookies";


const ShopDetail = () => {
    const [products, setProducts] = useState(null);
    const {shopId} = useParams();
    const nav = useNavigate();

    useEffect(() => {
        const loadProducts = async () => {
            let {data} = await Apis.get(endpoints['products-by-shopid'](shopId));
            setProducts(data); 
        }

        loadProducts();
    }, []);

    const addProduct = () =>{
        cookie.save("shopId", shopId);
        cookie.save("productStatus", "create")
        nav("/addProduct");
    }

    const changeProduct = (pId) =>{
        cookie.save("productId", pId);
        cookie.save("productStatus", "change")
        nav("/addProduct");
    }

    if (products === null) 
        return <MySpinner />

    if (products.length === 0)
        return <Alert variant="info" className="mt-1">Không có sản phẩm nào!</Alert>

    return (
        <>
            <h1 className="text-center text-info">DANH MỤC SẢN PHẨM</h1>
            <Button onClick={addProduct} style={{ width: '10rem', height: '3rem', marginRight: "20px" }} className="btn btn-info" variant="primary">Thêm sản phẩm</Button>
            <Row>
                {products.map(p => {
                    return <Col xs={12} md={3} className="mt-2 mb-2">
                                <Card style={{ width: '18rem', height: '35rem' }}>
                                    <Card.Img variant="top" src={p.image} fluid rounded  />
                                    <Card.Body>
                                        <Card.Title>{p.name}</Card.Title>
                                        <Card.Text>{p.price} VNĐ</Card.Text>
                                        <Button onClick={()=>changeProduct(p.id)} className="btn btn-info" style={{marginRight: "5px"}} variant="primary">Cập nhật</Button>
                                    </Card.Body>
                                </Card>
                            </Col>
                })}
            
        </Row>
        </>
    )
}

export default ShopDetail