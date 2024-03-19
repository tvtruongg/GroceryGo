const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const image_base_url = helper.ImagePath()

module.exports.controller = (app, io, user_socket_connect_list) => {

    app.post('/api/grocerygo/zone', (require, response) => {
        helper.Dlog(require.body);

        db.query("SELECT `zone_id`, `z_name` FROM `zone` WHERE `z_status`= ?", ["1"], (error, zoneResult) => {
            if (error) {
                helper.ThrowHtmlError(error, response);
                return;
            } else {
                db.query("CALL `pr_area_zone`(?)", ["1"], (error, areaResult) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response);
                        return;
                    }

                    zoneResult.forEach((zObj) => {
                        zObj.area_list = areaResult[0].filter((aObj) => {
                            return aObj.zone_id == zObj.zone_id
                        })
                    })

                    response.json({ "status": "1", "payload": zoneResult, "message": message.msg_success })
                })
            }
        })
    })

    app.post('/api/grocerygo/home', (request, response) => {
        helper.Dlog(request.body);
        checkAccessToken(request.headers, response, "1", (client) => {

            db.query("CALL grocerygo.pr_product_home(?);", [image_base_url], 
            (error, result) => {
                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return;
                }

                response.json({
                    "status": "1", 
                    "payload": {
                        "exclusive_offer": result[0],
                        "best_sell": result[1],
                        "favorite_product": result[2],
                        "category_list": result[3],
                        "product_new": result[4],
                    }, 
                    "message": message.msg_success
                })
            })

        })
    })

    // Chi tiết sản phẩm
    app.post('/api/grocerygo/product/detail', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;
        checkAccessToken(request.headers, response, "1", (client) => {
            helper.CheckParameterValid(response, reqObject, ["product_id"], () => {

                getProductDetail(response, client.user_id, reqObject.product_id, image_base_url);

            })
        })
    })

    // Bình luận
    app.post('/api/grocerygo/commnet', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["review_id", "from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_review_details(?, ?, ?, ?);", [reqObject.review_id, reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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

    // Giảm Giá
    app.post('/api/grocerygo/home/all/exclusive/offer', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_exclusive_offer(?, ?, ?);", [reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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

    // Bán nhiều
    app.post('/api/grocerygo/home/all/best/selling', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_best_selling(?, ?, ?);", [reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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

    // Yêu thích
    app.post('/api/grocerygo/home/all/favorite/product', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_favorite_product(?, ?, ?);", [reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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

    // Thể loại
    app.post('/api/grocerygo/home/all/category', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_category(?, ?, ?);", [reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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

    // Sản phẩm mới
    app.post('/api/grocerygo/home/all/product/new', (request, response) => {
        helper.Dlog(request.body)
        var reqObject = request.body;

        checkAccessToken(request.headers, response, "1", () => {
            helper.CheckParameterValid(response, reqObject, ["from", "quantity"], () => {

                db.query("CALL grocerygo.pr_all_product_new(?, ?, ?);", [reqObject.from, reqObject.quantity, image_base_url], (error, result) => {
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
