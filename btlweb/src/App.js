import { BrowserRouter, Route, Routes } from "react-router-dom";
import Header from "./layout/Header";
import Footer from "./layout/Footer";
import Home from "./components/Home";

const App = () =>{
  return (
    <>
      <BrowserRouter>
        <Header />
          <Routes>
            <Route path="/" element={<Home/>} />
          </Routes> 
        <Footer />
      </BrowserRouter>
    </>
  )
}

export default App;
