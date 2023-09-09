import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./components/Home";
import Footer from "./layout/Footer";
import Header from "./layout/Header";
import 'bootstrap/dist/css/bootstrap.min.css';
import { Container } from "react-bootstrap";
import Login from "./components/Login";
import { createContext, useReducer } from "react";
import MyUserReducer from "./reducers/MyUserReducer";
import cookie from "react-cookies";
import Register from "./components/Register";
import MyCartCounterReducer from "./reducers/MyCartCounterReducer";
import Cart from "./components/Cart";
import ProductDetails from "./components/ProductDetails";
import 'moment/locale/vi';
import Shop from "./components/Shop";
import ShopDetail from "./components/ShopDetail";
import AddOrUpdateShop from "./components/AddOrUpdateShop";
import AddOrUpdateProduct from "./components/AddOrUpdateProduct";
import UnactiveUsers from "./components/UnactiveUsers";

export const MyUserContext = createContext();
export const MyCartContext = createContext();

const countCart = () => {
  let cart = cookie.load("cart") || null;
  if (cart !== null)
    return Object.values(cart).reduce((init, current) => init + current["quantity"], 0);
  return 0;
}

const App = () => {
  const [user, dispatch] = useReducer(MyUserReducer, cookie.load("user") || null);
  const [cartCounter, cartDispatch] = useReducer(MyCartCounterReducer, countCart());

  return (
    <MyUserContext.Provider value={[user, dispatch]}>
      <MyCartContext.Provider value={[cartCounter, cartDispatch]}>
      <BrowserRouter>
        <Header />
        <Container>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/cart" element={<Cart />} />
            <Route path="/products/:productId" element={<ProductDetails />} />
            <Route path="/shop/:userId" element={<Shop />} />
            <Route path="/shop/:shopId" element={<ShopDetail />} />
            <Route path="/addShop" element={<AddOrUpdateShop />} />
            <Route path="/addProduct" element={<AddOrUpdateProduct />} />
            <Route path="/managerUser" element={<UnactiveUsers />} />
          </Routes>
        </Container>
        <Footer />
      </BrowserRouter>
      </MyCartContext.Provider>
    </MyUserContext.Provider>
  )
}

export default App;
