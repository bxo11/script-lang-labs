## happy path
* greet
  - utter_greet
* mood_great
  - utter_happy

## sad path 1
* greet
  - utter_greet
* mood_unhappy
  - utter_cheer_up
  - utter_did_that_help
* affirm
  - utter_happy

## sad path 2
* greet
  - utter_greet
* mood_unhappy
  - utter_cheer_up
  - utter_did_that_help
* deny
  - utter_goodbye

## say goodbye
* goodbye
  - utter_goodbye

## bot challenge
* bot_challenge
  - utter_iamabot

## restaurant work hours 1
* greet
  - utter_greet
* restaurant_work_hours
  - action_open_hours
  
## restaurant work hours 2
* restaurant_work_hours
  - action_open_hours

## list menu items 1
* greet
  - utter_greet
* list_menu_items
  - action_menu_list
  
## list menu items 2
* list_menu_items
  - action_menu_list

## pickup no-comment 
* place_order
  - action_save_order
  - utter_ask_for_comment
* deny
  - utter_ask_for_deliver_option
* pickup_option
  - action_confirm_order
* affirm
  - utter_goodbye
  
## pickup no-comment reorder
* place_order
  - action_save_order
  - utter_ask_for_comment
* deny
  - utter_ask_for_deliver_option
* pickup_option
  - action_confirm_order
* deny
  - utter_ask_for_reorder
  
## pickup comment 
* place_order
  - action_save_order
  - utter_ask_for_comment
* affirm
  - utter_ask_for_details
* provide_details
  - action_save_details
  - utter_ask_for_deliver_option
* pickup_option
  - action_confirm_order
* affirm
  - utter_goodbye
  
## pickup comment reorder
* place_order
  - action_save_order
  - utter_ask_for_comment
* affirm
  - utter_ask_for_details
* provide_details
  - action_save_details
  - utter_ask_for_deliver_option
* pickup_option
  - action_confirm_order
* deny
  - utter_ask_for_reorder


## delivery no-comment 
* place_order
  - action_save_order
  - utter_ask_for_comment
* deny
  - utter_ask_for_deliver_option
* delivery_option
  - utter_ask_for_address
* my_address_is
  - action_save_address
  - action_confirm_order_with_address
* affirm
  - utter_goodbye
  
## delivery no-comment reorder
* place_order
  - action_save_order
  - utter_ask_for_comment
* deny
  - utter_ask_for_deliver_option
* delivery_option
  - utter_ask_for_address
* my_address_is
  - action_save_address
  - action_confirm_order_with_address
* deny
  - utter_ask_for_reorder
  
## delivery comment 
* place_order
  - action_save_order
  - utter_ask_for_comment
* affirm
  - utter_ask_for_details
* provide_details
  - action_save_details
  - utter_ask_for_deliver_option
* delivery_option
  - utter_ask_for_address
* my_address_is
  - action_save_address
  - action_confirm_order_with_address
* affirm
  - utter_goodbye
  
## delivery comment reorder
* place_order
  - action_save_order
  - utter_ask_for_comment
* affirm
  - utter_ask_for_details
* provide_details
  - action_save_details
  - utter_ask_for_deliver_option
* delivery_option
  - utter_ask_for_address
* my_address_is
  - action_save_address
  - action_confirm_order_with_address
* deny
  - utter_ask_for_reorder

