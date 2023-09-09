import { useEffect, useState, useContext } from "react"
import { Alert, Button, Card, Col, Row } from "react-bootstrap";
import { Link, useNavigate, useParams } from "react-router-dom";
import { MyUserContext } from "../App";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";
import cookie from "react-cookies";

const Shop = () => {
    const [user,] = useContext(MyUserContext);
    const { userId } = useParams();
    const [shops, setShops] = useState(null);
    const nav = useNavigate();

    useEffect(() => {
        const loadShops = async () => {
            let { data } = await Apis.get(endpoints['shops-by-userid'](userId));
            setShops(data);
        }

        loadShops();
    });

    const changeShop = (shopInfo) => {
        cookie.save("shopId", shopInfo.id);
        cookie.save("shopName", shopInfo.name);
        cookie.save("shopDescription", shopInfo.description);
        nav("/addShop");
    }

    const addShop = () => {
        cookie.remove("shopId");
        cookie.remove("shopName");
        cookie.remove("shopDescription");
        nav("/addShop");
    }


    if (shops === null)
        return <MySpinner />

    return (
        <>
            <h1 className="text-center text-info">Quản lý cửa Hàng</h1>

            {user === null ? <>
                <Link to="/login">đăng nhập</Link>
            </> : <>
                <Button onClick={addShop} style={{ width: '10rem', height: '3rem', marginRight: "20px" }} className="btn btn-info" variant="primary">Thêm cửa hàng</Button>
                <Row>
                    {shops.map(s => {
                        return <Col xs={12} md={3} className="mt-2 mb-2">
                            <Card style={{ width: '18rem', height: '10rem' }}>
                                <Card.Body>
                                    <Card.Title>{s.name}</Card.Title>
                                    <Card.Text>{s.description}</Card.Text>
                                    <Link to={`/shop/${s.id}`} className="btn btn-info" style={{ marginRight: "5px" }} variant="primary">Xem chi tiết</Link>
                                    <Button onClick={() => changeShop(s)} className="btn btn-info" style={{ marginRight: "5px" }} variant="primary">Cập nhật</Button>
                                </Card.Body>
                            </Card>
                        </Col>
                    })}
                </Row>
            </>}
        </>
    )
}

export default Shop