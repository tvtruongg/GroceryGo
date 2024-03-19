const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const image_base_url = helper.ImagePath()

module.exports.controller = (app, io, user_socket_connect_list) => {

    // API Category
    app.post('/api/grocerygo/explore/list', (request, response) => {
        helper.Dlog(request.body)

        checkAccessToken(request.headers, response, '1', () => {

            db.query("SELECT category.category_id, category.ca_name, (CASE WHEN category.ca_image != '' THEN  CONCAT('" + image_base_url + "' ,'', category.ca_image) ELSE '' END) AS `ca_image` , category.ca_color FROM `category` WHERE category.ca_status = 1 ORDER BY category.category_id DESC", 
            [], (error, result) => {
                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                response.json({
                    "status": "1",
                    "payload": result,
                    "message": message.msg_success
                })

            })
        })
    })

    app.post('/api/grocerygo/explore/product/list', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["category_id", "from", "quantity"], () => {

                db.query("CALL grocerygo.product_favorite(?, ?, ?, ?);", [reqObject.category_id, reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
                        if (error) {
                            helper.ThrowHtmlError(error, response);
                            return
                        }
        
                        response.json({
                            "status": "1",
                            "payload": result[0],
                            "message": message.msg_success
                        })
                    })
            })
        })
    })
}