const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const message = require('../../common/message')

module.exports.controller = (app, io, user_socket_connect_list) => {
    
    // Methods Post
    app.post('/api/grocerygo/login', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["u_email", "u_password"], () => {

            // Cập nhật token cho phiên đăng nhập
            var u_access_token = helper.createRequestToken();
            db.query("UPDATE `user` SET u_access_token = ?, u_modify_date = NOW() WHERE u_email = ? AND u_password = ? AND u_status = 1", [u_access_token, reqObject.u_email, reqObject.u_password], (error, result) => {

                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                // Lấy ra thông tin
                if (result.affectedRows > 0) {
                    db.query("SELECT user_id, u_type, user_name, u_email, u_refresh_token, u_access_token, u_mobile_code, u_reset_code, u_status, u_created_date, u_modify_date FROM `user` WHERE `u_email` = ? AND `u_password` = ? AND `u_status` = 1;", [reqObject.u_email, reqObject.u_password], 
                    (error, result) => {
                        if(error) {
                            helper.ThrowHtmlError(error, result);
                            return
                        }
                        
                        if(result.length > 0) {
                            response.json({'status': '1', "payload": result[0], "message": message.msg_success})
                        } else {
                            response.json({'status': '0', "message": message.msg_invalidUser})
                        }
                    })
                } else {
                    response.json({ "status": "0", "message": message.msg_invalidUser })
                }

            })
        
        })
    })

    // API Signup
    app.post('/api/grocerygo/signup', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        // Kiểm tra định dạng
        helper.CheckParameterValid(response, reqObject, ["user_name", "u_email", "u_password"], () => {

            // Kiểm tra xem email đã tồn tại chưa
            db.query('SELECT user_id, u_status FROM `user` WHERE u_email = ? ', [reqObject.u_email], (error, result) => {

                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                if (result.length > 0) {
                    response.json({ "status": "1", "payload": result[0], "message": message.msg_already_register })
                } else {

                    // Tạo 1 tài khoản mới
                    var u_access_token = helper.createRequestToken();
                    db.query("INSERT INTO `user` (`user_name`, `u_email`, `u_password`, `u_refresh_token`, `u_access_token`) VALUES (?, ?, ?, ?, ?)", [reqObject.user_name, reqObject.u_email, reqObject.u_password, u_access_token, ''], (error, result) => {
                        if (error) {
                            helper.ThrowHtmlError(error, response);
                            return
                        }

                        // Tạo xong trả về thông tin
                        if (result) {
                            db.query("SELECT user_id, u_type, user_name, u_email, u_refresh_token, u_access_token, u_mobile_code, u_reset_code, u_status, u_created_date, u_modify_date FROM `user` WHERE user_id = ?, u_status = 1;", [result.insertId], (error, result) => {

                                if (error) {
                                    helper.ThrowHtmlError(error, response);
                                    return
                                }

                                if (result.length > 0) {
                                    response.json({ "status": "1", "payload": result[0], "message": message.msg_success })
                                } else {
                                    response.json({ "status": "0", "message": message.msg_invalidUser })
                                }
                            })
                        } else {
                            response.json({ "status": "0", "message": message.msg_fail })
                        }
                    })

                }
            })
        })
    })
};
























