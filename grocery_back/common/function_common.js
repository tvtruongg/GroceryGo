const helper = require('../helper/helper')
const db = require('../helper/db_helper');
const message = require('./message');

// Kiểm tra phiên đăng nhập
function checkAccessToken(headerObject, response, userType = "", callback) {
    helper.Dlog(headerObject.access_token);
    helper.CheckParameterValid(response, headerObject, ["access_token"], () => {
        db.query("SELECT user_id, u_type, user_name, u_email, u_refresh_token, u_access_token, u_mobile_code, u_reset_code, u_status, u_modify_date FROM `user` WHERE u_access_token = ? AND u_status = 1", [headerObject.access_token], (error, result) => {
            if (error) {
                helper.ThrowHtmlError(error, response);
                return
            }

            helper.Dlog(result);

            if (result.length > 0) {
                if (userType != "") {
                    if (userType == result[0].u_type) {
                        return callback(result[0]);
                    } else {
                        response.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access!" })
                    }
                } else {
                    return callback(result[0]);
                }
            } else {
                response.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
            }
        })
    })
};

// Thông tin chi tiết sản phẩm
function getProductDetail(response, user_id, product_id, url) {
    db.query("CALL grocerygo.pr_product_details(?, ?, ?);", [user_id, product_id, url], 
    (error, result) => {

        if (error) {
            helper.ThrowHtmlError(error, response);
            return;
        }

        if (result[0].length > 0) {

            result[0][0].image_list = result[1];

            response.json({
                "status": "1", 
                "payload": {
                    "product": result[0][0],
                    "review": result[2],
                    "brand": result[3],
                    "suggest": result[4]
                },
                "message": message.msg_success
            });
        } else {
            response.json({ "status": "0", "message": "invalid item" })
        }
    })
}

// Xuất bản
module.exports = {
    checkAccessToken,
    getProductDetail
}