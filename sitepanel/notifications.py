from sitepanel.models import UserProfile
from firebase_admin import messaging


def send_notification(fcm_token, title, body, data=None):
    message = messaging.Message(
        notification=messaging.Notification(title=title, body=body),
        token=fcm_token,
        data=data
    )
    response = messaging.send(message)
    print(f"Notification sent successfully: {response}")


def send_web_notification(title, body, registration_id):
    try:
       
        # Create a message
        message = messaging.Message(
            notification=messaging.Notification(title=title, body=body),
            token=registration_id
        )

        # Send the message
        response = messaging.send(message)
        print(f"Notification sent successfully: {response}")
        return True
    except UserProfile.DoesNotExist:
        print("User profile with given registration ID not found.")
        return False
    except Exception as e:
        print("Error sending notification:", e)
        return False
