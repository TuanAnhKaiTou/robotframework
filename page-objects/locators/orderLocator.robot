*** Variables ***
${btn_yep}                      xpath=//div[@class="modal-body"]/div/button[contains(@class, "btn-warning")]

${select_head}                  head
${input_body}                   id=id-body-
${input_legs}                   xpath=//label[contains(text(), "Legs:")]/following-sibling::input
${input_address}                address
${btn_preview}                  preview
${btn_order}                    order
${img_robot_preview}            robot-preview-image

${lbl_receipt}                  receipt
${lbl_orderid}                  //*[@id="receipt"]/p[1]
${btn_order_another_robot}      order-another
