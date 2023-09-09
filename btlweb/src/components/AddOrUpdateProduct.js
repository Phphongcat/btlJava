import { useState, useEffect, useRef } from "react";
import { Button, Form, Alert } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";
import cookie from "react-cookies";

const AddOrUpdateProduct = () => {
    const [product, setProduct] = useState({
        "name": "",
        "description": "",
        "price": "",
        "categoryId": "",
        "shopId": "",
    });
    const [shopId,] = useState(cookie.load("shopId"));
    const [categories, setCategories] = useState(null);
    const [loading, setLoading] = useState(false);
    const file = useRef();
    const [err, setErr] = useState(null);
    const nav = useNavigate();

    const loadCates = async () => {
        let res = await Apis.get(endpoints['categories'])
        setCategories(res.data);
    }

    useEffect(() => {
        loadCates();
    }, [])

    const register = (evt) => {
        evt.preventDefault();

        const process = async () => {
            let form = new FormData();

            for (let field in product) {
                if (field !== "categoryId" && field !== "shopId")
                    form.append(field, product[field]);
            }
            if (product["categoryId"] === "")
            form.append("categoryId", categories[0].id);
            else
                form.append("categoryId", product["categoryId"]);
            form.append("shopId", shopId);
            form.append("file", file.current.files[0]);

            console.log("categoryId" + form.get("categoryId"));
            console.log("shopId" + form.get("shopId"));
            console.log("name" + form.get("name"));

            setLoading(true)
            let res = await Apis.post(endpoints['products'], form);
            if (res.status === 201) {
                nav("/shop");
            } else
                setErr("Hệ thống bị lỗi!");
        }

        process();
    }

    const change = (evt, field) => {
        setProduct(current => {
            return { ...current, [field]: evt.target.value }
        })
    }

    return <>
        <h1 className="text-center text-info mt-2">THÊM SẢN PHẨM</h1>

        {err === null ? "" : <Alert variant="danger">{err}</Alert>}

        <Form onSubmit={register}>
            <Form.Group className="mb-3">
                <Form.Label>Tên sản phẩm</Form.Label>
                <Form.Control type="text" onChange={(e) => change(e, "name")} placeholder="Tên sản phẩm" required />
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Mô tả</Form.Label>
                <Form.Control type="text" onChange={(e) => change(e, "description")} placeholder="Mô tả" required />
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Giá sản phẩm</Form.Label>
                <Form.Control type="text" onChange={(e) => change(e, "price")} placeholder="Giá sản phẩm" required />
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Loại sản phẩm</Form.Label>
                {
                    categories !== null ? <>
                        <Form.Select defaultValue={"1"} onChange={(e) => change(e, "categoryId")} aria-label="Default select example">
                            {categories.map(c => {
                                return <option value={c.id}>{c.name}</option>
                            })}
                        </Form.Select></>
                        : <></>
                }
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Ảnh đại diện</Form.Label>
                <Form.Control type="file" ref={file} required/>
            </Form.Group>
            <Form.Group className="mb-3">
                {loading === true ? <MySpinner /> : <Button variant="info" type="submit">Xác nhận</Button>}

            </Form.Group>
        </Form>
    </>
}

export default AddOrUpdateProduct;