var db = require('../../helper/db_helper')
var helper = require('../../helper/helper')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')      

module.exports.controller = (app, io, user_socket_connect_list) => {

    // API Add
    app.post('/api/grocerygo/admin/brand/add', (request, response) => {
        // In thông báo body được nhập
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["b_name"], () => {

            // Kiểm tra token
            checkAccessToken(request.headers, response, "2", () => {

                // Kiểm tra xem tên brand đã tồn tại chưa
                db.query("SELECT brand_id, b_name FROM `brand` WHERE b_name  = ? AND b_status = ?", [reqObject.b_name, "1"], (error, result) => {
                    if (error) {
                        helper.ThrowHtmlError(error, response);
                        return;
                    }

                    if (result.length > 0) {
                        response.json({ "status": "1", "payload": result[0], "message":message.msg_already_added });

                    } else {
                        db.query("INSERT INTO `brand`( `b_name`, `b_created_date`, `b_modify_date`) VALUES (?, NOW(), NOW())", [
                            reqObject.b_name
                        ], (error, result) => {

                            if (error) {
                                helper.ThrowHtmlError(error, response);
                                return;
                            }

                            if (result) {
                                response.json({
                                    "status": "1", "payload": {
                                        "brand_id": result.insertId,
                                        "b_name": reqObject.b_name,
                                    }, "message": message.msg_brand_added
                                });
                            } else {
                                response.json({ "status": "0", "message": message.msg_fail })
                            }
                        })

                    }
                })

            },);
        })
    })

    // API Update
    app.post('/api/grocerygo/admin/brand/update', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["brand_id", "b_name"], () => {

            checkAccessToken(request.headers, response, "2", () => {
                db.query("UPDATE `brand` SET b_name = ?, b_modify_date = NOW() WHERE brand_id = ? AND b_status = ? ", [
                    reqObject.b_name, reqObject.brand_id, "1"
                ], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, request);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1", "message": message.msg_brand_update
                        });
                    } else {
                        response.json({ "status": "0", "message": message.msg_fail })
                    }

                })



            },)
        })
    })

    // API Delete
    app.post('/api/grocerygo/admin/brand/delete', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["brand_id"], () => {

            checkAccessToken(request.headers, response, "2", () => {
                db.query("UPDATE `brand` SET b_status = ?, b_modify_date = NOW() WHERE brand_id = ? ", [
                    "2", reqObject.brand_id,
                ], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1", "message": message.msg_brand_delete
                        });
                    } else {
                        response.json({ "status": "0", "message": message.msg_fail })
                    }

                })
            },)
        })
    })

    // API Get
    app.post('/api/grocerygo/admin/brand/list', (request, response) => {
        helper.Dlog(request.body);

        checkAccessToken(request.headers, response, "2", () => {
            db.query("SELECT brand_id, b_name FROM `brand` WHERE b_status = ? ", [
                "1"
            ], (error, result) => {

                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return;
                }

                response.json({
                    "status": "1", "payload": result
                });
            })
        },)
    })
};
























