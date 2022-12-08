from discord.ext import commands
import requests 
import json

TOKEN = 'MTA0NzYwNTI4ODkzNDU3NjE3OA.GqcaKr.muTocVAJzqngaH3TNc3l75TiIUgBCGfGfbpqJI'


class ChatBot(commands.Bot):
    def __init__(self, prefix):
        self.bot_prefix = prefix
        super().__init__(command_prefix=prefix, help_command=None)

    def run(self):
        super().run(TOKEN, reconnect=True)

    async def on_ready(self):
        print('Logged in as:')
        print('Username: ' + self.user.name)
        print('------')

    async def on_message(self, message):
        if message.author == self.user:
            return
        data = {
          "sender": message.author.name,
          "message": message.content
        }
        
        r = requests.post('http://localhost:5005/webhooks/rest/webhook', json=data)
        data = r.json()

        await message.channel.send(data[0]['text'])


if __name__ == '__main__':
    chat_bot = ChatBot('.')
    chat_bot.run()
