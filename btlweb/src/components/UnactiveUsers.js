import { useContext, useEffect, useState } from "react"
import { Alert, Button, Card, Col, Row } from "react-bootstrap";
import { Link, useNavigate } from "react-router-dom";
import { MyUserContext } from "../App";
import Apis, { endpoints } from "../configs/Apis";
import MySpinner from "../layout/MySpinner";

const UnactiveUsers = () => {
    const [users, setUsers] = useState(null);
    const [loading, setLoading] = useState(false);
    const [err, setErr] = useState(null);
    const nav = useNavigate();

    useEffect(() => {
        const loadUnactiveUsers = async () => {
            let {data} = await Apis.get(endpoints['unactive-users']);
            setUsers(data); 
        }

        loadUnactiveUsers();
    }, []); 

    const setActiveUser = async (userId, active) => {
        if(loading === false)
        {
            let activeValue = active ? 1 : 0;
            let form = new FormData();
            form.append("userId", userId);
            form.append("userActive", activeValue);

            setLoading(true);
            let res = await Apis.post(endpoints['update-sale-user'], form);
            if (res.status === 200) {
                window.location.reload(true);
            } else
                setErr("Hệ thống bị lỗi!");
        }
    }

    if (users === null) 
        return <MySpinner />

    if (users.length === 0)
        return <Alert variant="info" className="mt-1">Chưa có tài khoản nào cần kích hoạt!</Alert>

   return (
        <>

        {err === null ? "" : <Alert variant="danger">{err}</Alert>}

        <h1 className="text-center text-info">Quản lý tài khoản</h1>
        <Row>
                {users.map(u => {
                    return <Col xs={12} md={3} className="mt-2 mb-2">
                                <Card style={{ width: '18rem', height: '10rem' }}>
                                    <Card.Body>
                                        <Card.Title>{u.username}</Card.Title>
                                        <Card.Text>{u.email}</Card.Text>
                                        {
                                            u.active ? <>
                                                <Button onClick={()=>setActiveUser(u.id, false)} className="btn btn-info" style={{marginRight: "5px"}} variant="primary">Khoá</Button>
                                            </> : <>
                                                <Button onClick={()=>setActiveUser(u.id, true)} className="btn btn-info" style={{marginRight: "5px"}} variant="primary">Kích hoạt</Button>
                                            </>
                                        }
                                        
                                    </Card.Body>
                                </Card>
                            </Col>
                })}
        </Row>
        </>
    )
}

export default UnactiveUsers