# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/core/actions/#custom-actions/


# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import json
from rasa_sdk.events import SlotSet
from rasa_sdk.forms import FormAction
from typing import Any, Text, Dict, List, Union


class ActionOpenHours(Action):
    def name(self):
        return 'action_open_hours'

    
    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        day = next(tracker.get_latest_entity_values("day"), None)
        f = open('opening_hours.json')
        data = json.load(f)
        f.close()
        if day not in data['items']:
            message = f'Sorry, I do not know that day'
            dispatcher.utter_message(message)
            return []
                
        open_h = data['items'][day]['open']
        close_h = data['items'][day]['close']
        
        if open_h==close_h:
            message = f'We do not work on {day}'
        else:
            message = f'On {day}, we work between {open_h} and {close_h}'    
        dispatcher.utter_message(message)
        return []

class ActionMenuList(Action):
    def name(self):
        return 'action_menu_list'


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        f = open('menu.json')
        data = json.load(f)
        f.close()
        message = f'We serve:\n'
        for i, dish in enumerate(data['items']):
            message+=f"{i+1}. {dish['name']} - {dish['price']}$\n"

        dispatcher.utter_message(message)
        return []
    

class ActionConfirmOrder(Action):
    def name(self):
        return 'action_confirm_order'


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        f = open('menu.json')
        data = json.load(f)
        f.close()
        order = tracker.get_slot("order")
        comment = tracker.get_slot("comment")
        preparation_time = 0

        for dish in data['items']:
            if dish['name'] == order:  
                preparation_time = dish['preparation_time']
                break
        message = f'Your order: {order} will be ready in {preparation_time * 60} minutes\nYour comment: {comment}\nYou choosed self pick-up delivery\nIs everything fine with your order?'
   
        dispatcher.utter_message(message)
        return []
    
class ActionConfirmOrderWithAddress(Action):
    def name(self):
        return 'action_confirm_order_with_address'


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        f = open('menu.json')
        data = json.load(f)
        f.close()
        order = tracker.get_slot("order")
        comment = tracker.get_slot("comment")
        preparation_time = 0
       
        for dish in data['items']:
            if dish['name'] == order:  
                preparation_time = dish['preparation_time']
                break
        address = tracker.get_slot('address')
        message = f'Your order: {order} will be ready in {preparation_time * 60} minutes\nYour comment: {comment}\nDelivery to: {address}\nIs everything fine with your order?'

        dispatcher.utter_message(message)
        return []
    

class ActionSaveDetails(Action):
    def name(self):
        return 'action_save_details'


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        comment = tracker.latest_message['text']
        return [SlotSet("comment", comment)]
    
class ActionSaveAddress(Action):
    def name(self):
        return 'action_save_address'


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        address = tracker.latest_message['text']
        return [SlotSet("address", address)]
    
# class emailForm(FormAction):
#     """Example of a custom form action"""

#     def name(self):
#         # type: () -> Text
#         """Unique identifier of the form"""

#         return "email_form"

#     @staticmethod
#     def required_slots(tracker: Tracker) -> List[Text]:
#         """A list of required slots that the form has to fill"""

#         return ["emailbody"]

#     def slot_mappings(self):
#         # type: () -> Dict[Text: Union[Dict, List[Dict]]]
#         """A dictionary to map required slots to
#             - an extracted entity
#             - intent: value pairs
#             - a whole message
#             or a list of them, where a first match will be picked"""

#         return {"emailbody": [self.from_text()]}

    
#     def submit(self,
#                dispatcher: CollectingDispatcher,
#                tracker: Tracker,
#                domain: Dict[Text, Any]) -> List[Dict]:
#         """Define what the form has to do
#             after all required slots are filled"""

#         # utter submit template
#         dispatcher.utter_template('utter_submit', tracker)
#         return []

