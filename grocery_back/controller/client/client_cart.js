const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const image_base_url = helper.ImagePath()

module.exports.controller = (app, io, user_socket_connect_list) => {
    app.post('/api/grocerygo/cart/add', (request, response) => {
        helper.Dlog(request.body)
        var reqObjson = request.body

        checkAccessToken(request.headers, response, "1", (client) => {
            helper.CheckParameterValid(response, reqObjson, ["product_id", "c_quantity"], () => {

                db.query("SELECT * FROM product WHERE product.product_id = ? AND product.p_status = 1;", [reqObjson.product_id], (error, result) => {
                    if (error) {
                        helper.ThrowHtmlError(error, response)
                        return;
                    }

                    if (result.length > 0) {
                        db.query("INSERT INTO `cart` (`user_id`, `product_id`, `c_quantity`) VALUES (?,?,?);", [client.user_id, reqObjson.product_id, reqObjson.c_quantity], (error, result) => {
                            if (error) {
                                helper.ThrowHtmlError(error, response)
                                return
                            }

                            if (result) {
                                response.json({
                                    "status": "1",
                                    "message": message.msg_add_to_item
                                })
                            } else {
                                response.json({
                                    "status": "0",
                                    "message": message.msg_fail
                                })
                            }
                        })
                    } else {
                        response.json({
                            "status": "0",
                            "message": message.msg_invalid_item
                        })
                    }
                })
            })
        })
    })

    app.post('/api/grocerygo/cart/update', (request, response) => {
        helper.Dlog(request.body)
        var reqObjson = request.body

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObjson, ["cart_id", "c_quantity"], () => {
                // Kiểm tra số sản phẩm tối đa 10 sản phẩm
                var quantity = 0;
                if (reqObjson.c_quantity < "1") {
                    quantity = "1"
                } else if (reqObjson.c_quantity > "10") {
                    quantity = "10"
                } else {
                    quantity = reqObjson.c_quantity
                }
                db.query("UPDATE `cart` SET cart.c_quantity = ? WHERE cart.cart_id = ? AND cart.c_status = 1;", [quantity, reqObjson.cart_id], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response)
                        return
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1",
                            "message": message.msg_success
                        })
                    } else {
                        response.json({
                            "status": "0",
                            "message": message.msg_fail
                        })
                    }
                })

            })
        })
    })

    app.post('/api/grocerygo/cart/remove', (request, response) => {
        helper.Dlog(request.body)
        var reqObjson = request.body

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObjson, ["cart_id"], () => {

                db.query("UPDATE `cart` SET cart.c_status = 2 WHERE cart.cart_id = ?;", [reqObjson.cart_id], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response)
                        return
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1",
                            "message": message.msg_remove_to_cart
                        })
                    } else {
                        response.json({
                            "status": "0",
                            "message": message.msg_fail
                        })
                    }
                })

            })
        })
    })

    app.post('/api/grocerygo/cart/list', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body

        checkAccessToken(request.headers, response, "1", (client) => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_cart_view(?, ?, ?, ?);", [client.user_id, reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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