import { useState, useContext } from "react";
import { Button, Form, Alert } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";
import { MyUserContext } from "../App";
import cookie from "react-cookies";

const AddOrUpdateShop = () => {
    const [shop, setShop] = useState({
        "name": "",
        "description": "",
    });
    const [user,] = useContext(MyUserContext);
    const [loading, setLoading] = useState(false);
    const [sId,] = useState(cookie.load("shopId") || null);
    const [shopName,] = useState(cookie.load("shopName") || null);
    const [shopDescription,] = useState(cookie.load("shopDescription") || null);
    const [err, setErr] = useState(null);
    const nav = useNavigate();

    const register = (evt) => {
        evt.preventDefault();

        const process = async () => {
            let form = new FormData();

            for (let field in shop) {
                if ((shop[field] === null || shop[field] === ""))
                    continue;

                form.append(field, shop[field]);
            }

            if (form.get("name") === null) {
                form.append("name", shopName);
            }
            if (form.get("description") === null) {
                form.append("description", shopDescription);
            }
            if (sId === null)
                form.append("shopId", -1);
            else
                form.append("shopId", sId);

            form.append("userId", user.id);

            setLoading(true)
            let res = await Apis.post(endpoints['add-or-update-shop'], form);
            if (res.status === 201) {
                nav(`/shop/${user.id}`);
            } else
                setErr("Hệ thống bị lỗi!");
        }

        process();
    }

    const change = (evt, field) => {
        setShop(current => {
            return { ...current, [field]: evt.target.value }
        })
    }

    return <>
        <h1 className="text-center text-info mt-2">ĐĂNG KÝ CỬA HÀNG</h1>

        {err === null ? "" : <Alert variant="danger">{err}</Alert>}

        <Form onSubmit={register}>
            <Form.Group className="mb-3">
                <Form.Label>Tên cửa hàng</Form.Label>
                <Form.Control defaultValue={shopName === null ? "" : shopName} onChange={(e) => change(e, "name")} placeholder="Tên cửa hàng" required />
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Mô tả</Form.Label>
                <Form.Control defaultValue={shopDescription === null ? "" : shopDescription} type="text" onChange={(e) => change(e, "description")} placeholder="Mô tả" required />
            </Form.Group>
            <Form.Group className="mb-3">
                {loading === true ? <MySpinner /> : <Button variant="info" type="submit">Xác nhận</Button>}

            </Form.Group>
        </Form>
    </>
}

export default AddOrUpdateShop;