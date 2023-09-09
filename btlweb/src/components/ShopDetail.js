import { useEffect, useState } from "react"
import { Card, Col, Row, Alert, Button } from "react-bootstrap";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";
import { useParams, useNavigate } from "react-router-dom";
import cookie from "react-cookies";
import ReactPaginate from 'react-paginate';


const ShopDetail = () => {
    const [products, setProducts] = useState(null);
    const { shopId } = useParams();
    const nav = useNavigate();

    // paging index
    const [sId, setSId] = useState(null);
    const [eId, setEId] = useState(null);
    const perCount = 20;

    useEffect(() => {
        const loadProducts = async () => {
            let { data } = await Apis.get(endpoints['products-by-shopid'](shopId));
            setProducts(data);
        }

        setSId(0);
        setEId(perCount);

        loadProducts();
    }, []);

    const addProduct = () => {
        cookie.save("shopId", shopId);
        cookie.save("productStatus", "create")
        nav("/addProduct");
    }

    const changeProduct = (pId) => {
        cookie.save("productId", pId);
        cookie.save("productStatus", "change")
        nav("/addProduct");
    }

    const handlePageClick = (e) =>{
    
        setSId(e.selected * perCount);
        setEId(e.selected * perCount + perCount);
     }

    if (products === null)
        return <MySpinner />

    return (
        <>
            <h1 className="text-center text-info">DANH MỤC SẢN PHẨM</h1>
            <Button onClick={addProduct} style={{ width: '10rem', height: '3rem', marginRight: "20px" }} className="btn btn-info" variant="primary">Thêm sản phẩm</Button>
            <Row>
                {products.slice(sId, eId).map(p => {
                    return <Col xs={12} md={3} className="mt-2 mb-2">
                        <Card style={{ width: '18rem', height: '35rem' }}>
                            <Card.Img variant="top" src={p.image} fluid rounded />
                            <Card.Body>
                                <Card.Title>{p.name}</Card.Title>
                                <Card.Text>{p.price} VNĐ</Card.Text>
                                <Button onClick={() => changeProduct(p.id)} className="btn btn-info" style={{ marginRight: "5px" }} variant="primary">Cập nhật</Button>
                            </Card.Body>
                        </Card>
                    </Col>
                })}

                <ReactPaginate
                    breakLabel="..."
                    nextLabel="next >"
                    onPageChange={handlePageClick}
                    pageRangeDisplayed={5}
                    pageCount={Math.ceil(products.length / perCount)}
                    previousLabel="< previous"
                    renderOnZeroPageCount={null}
                    pageClassName="page-item"
                    pageLinkClassName="page-link"
                    previousClassName="page-item"
                    previousLinkClassName="page-link"
                    nextClassName="page-item"
                    nextLinkClassName="page-link"
                    breakClassName="page-item"
                    breakLinkClassName="page-link"
                    containerClassName="pagination"
                    activeClassName="active"
                />

            </Row>
        </>
    )
}

export default ShopDetail