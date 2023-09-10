import express from "express"
import { urlencoded, json } from "body-parser"
import cors from "cors"

const app = express()
require("dotenv").config()
const stripe = require("stripe")("sk_test_51NoUoMIHAM2U3sI6acRYiuuPIfiJ0P93fV4uQ9I9La7ntMn2QHkONyJXA2GIvQm8mPUGUl0ppMFuprsz0TdUpSiC00yz35EnRC")

app.use(urlencoded({ extended: true }))
app.use(json())

app.use(cors())

app.post("/payment", cors(), async (req, res) => {
	let { amount, id } = req.body
	try {
		const payment = await stripe.paymentIntents.create({
			amount,
			currency: "SGD",
			description: "E-Commerce",
			payment_method: id,
			confirm: true
		})
		console.log("Payment", payment)
		res.json({
			message: "Payment successful",
			success: true
		})
	} catch (error) {
		console.log("Error", error)
		res.json({
			message: "Payment failed",
			success: false
		})
	}
})

app.listen(process.env.PORT || 4000, () => {
	console.log("Sever is listening on port 4000")
})