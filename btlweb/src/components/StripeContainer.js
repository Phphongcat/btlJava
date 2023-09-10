import { loadStripe } from "@stripe/stripe-js";
import React from "react";
import { Elements } from "@stripe/react-stripe-js";
import PaymentForm from "./PaymentForm";

const PUBLIC_KEY = "pk_test_51NoUoMIHAM2U3sI68Jywmo1e97ZqjlUh9KtWgvA50aZtpuk9L3DXhTayH9qwfG2zRW7sqLhORtEBwK6WXrjLtSxh00gcyG1L4m"

const stripeTest = loadStripe(PUBLIC_KEY)

export default function StripeContiner(){
    return(
        <Elements stripe={stripeTest}>
            <PaymentForm/>

        </Elements>
    )
}