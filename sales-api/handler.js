const serverless = require("serverless-http");
const express = require("express");
const app = express();
app.use(express.json())

const AWS = require("aws-sdk") // STEP 2
const sns = new AWS.SNS({ region: "ap-northeast-2" }) // STEP 2

const {
  connectDb,
  queries: { getProduct, setStock }
} = require('./database')

app.get("/product/donut", connectDb, async (req, res, next) => {
  const [ result ] = await req.conn.query(
    getProduct('CP-502101')
  )
  if (result.length > 0) {
    return res.status(200).json(result[0]);
  } else {
    return res.status(400).json({ message: "상품 없음" });
  }
});

app.post("/checkout", connectDb, async (req, res, next) => {
  const [ result ] = await req.conn.query(
    getProduct('CP-502101')
  )
  if (result.length > 0) {
    const product = result[0]
    if (product.stock > 0) {
      await req.conn.query(setStock(product.product_id, product.stock - 1))
      return res.status(200).json({ message: `구매 완료! 남은 재고: ${product.stock - 1}`});
    }
    else {
      return res.status(200).json({ message: `구매 실패! 남은 재고: ${product.stock}`});
    }
  } else {
    return res.status(400).json({ message: "상품 없음" });
  }
});

app.use((req, res, next) => {
  return res.status(404).json({
    error: "Not Found",
  });
});

module.exports.handler = serverless(app);
module.exports.app = app;