const axios = require('axios').default

module.exports.handler = async (event) => {
    console.log(event)

    const body = JSON.parse(event.Records[0].body)
    const payload = {
        MessageGroupId: "stock-arrival-group",
        MessageAttributeProductId: body.MessageAttributes.MessageAttributeProductId.Value,
        MessageAttributeProductCnt: 10,
        MessageAttributeFactoryId: body.MessageAttributes.MessageAttributeFactoryId.Value,
        MessageAttributeRequester: "정승현",
        CallbackUrl: "https://dg546zlnoh.execute-api.ap-northeast-2.amazonaws.com/product/donut"
      // 어떤 형식으로 넣어야 할까요? Factory API 문서를 참고하세요.
      // 필요하다면 record.body를 활용하세요.
    }
    
    await axios.post('http://factory.p3.api.codestates-devops.be:8080/api/manufactures', payload)
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });
};
