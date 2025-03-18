import telebot
from robot.api import logger
from robot.api.deco import library, keyword


@library(scope = 'GLOBAL')
class TelegramLibrary:
    def __init__(self,
                 token=None,
                 channel_id=None,
                 default_parse_mode="MarkdownV2"):
        """
        TelegramLibrary

        Robotframework Library for sending Telegram Messages.
        """
        self.bot = telebot.TeleBot(token)
        self.channel_id = channel_id
        self.default_parse_mode = default_parse_mode

    @keyword
    def send_message(self, message, parse_mode=None):
        """
        Sends the given Message to the Current Set Channel.
        Channel must first be set on import.
        """
        logger.info(f'Message: {message} \n Parse Mode: {self.default_parse_mode if parse_mode else parse_mode}')
        return self.bot.send_message(self.channel_id,
                                     message,
                                     parse_mode="MarkdownV2").message_id

    @keyword
    def edit_message(self, message: str, edit_id, parse_mode=None):
        """
        """
        logger.info(f'Message: {message} \n Parse Mode: {self.default_parse_mode if parse_mode else parse_mode}')
        self.bot.edit_message_text(message,
                                   self.channel_id,
                                   edit_id,
                                   parse_mode="MarkdownV2")

    @keyword
    def send_photo(self, photo_path, message: str, parse_mode=None):
        """
        Sends the given Photo plus the caption text to the Current Set Channel.
        Channel must first be set on import.


        """
        logger.info(f'Message: {message} \n Parse Mode: {self.default_parse_mode if parse_mode else parse_mode}')
        logger.info(f'<img src="{photo_path}">', html=True)
        photo = open(photo_path, 'rb')
        self.bot.send_photo(self.channel_id,
                            photo,
                            caption=message.replace("-","\\-").replace(".","\\."),
                            parse_mode="MarkdownV2")
