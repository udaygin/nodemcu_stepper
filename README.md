# nodemcu_stepper
Nodemcu(esp8266) lua module to simplify driving a unipolar stepper motor 28BYJ-48 when using ULN2003 Driver
with this module you can drive a stepper motor in 3 lines like this 

```
stepper  = require ('stepper')
stepper.init({5,6,7,8})
stepper.rotate(stepper.FORWARD,2500,5,0,function () print('Rotation done.') end)
```
As you can see, your code trigger rotate and let the module finish rotation and trigger callback. 

### Background

I needed a simple lua module (with callbacks) that I can use to drive the cheap [ 28BYJ-48 & ULN2003 Combo](http://www.dx.com/p/dmdg-uln2003-stepper-motor-driver-module-5v-28byj-48-stepper-motor-for-arduino-349659#.WSWFznV97qw). I did search online around to see if there is a readymade one available. when I couldnt find any exact matches, Just wrote this based on bits and pieces I found online. Hope you find it useful. Feel free create issue or get in touch with me for any feature requests. 


**TODO : Insert pic here**
Fig: 28BYJ-48 & ULN2003 Combo


Here are two good links that helped me understand how to get the stepper working 
https://www.geeetech.com/wiki/index.php/Stepper_Motor_5V_4-Phase_5-Wire_%26_ULN2003_Driver_Board_for_Arduino
http://chilipeppr2.blogspot.in/2016/10/controlling-byj48-stepper-motor-from.html


### Download 
since this is a single module file, I suggest raw file download for stepper.lua instead of a checkout. this is ment to be used in your project. 

### Usage

#### Connections 

Any nodemcu gpio pins shoud work. here is the combination that worked for me. 

| NODEMCU | ULN2003 |
| ------------- | ------------- |
| D5 | IN1 |
| D6 | IN2 |
| D7 | IN3 |
| D8 | IN4 |

**TODO : Insert Connection/circuit diagram here**

### Compilation 
THis is a big module. It takes a lot of your esp8266's precious memory. I suggest you compile this in to a .lc file to reduce memory consumption. 

#### load 
load the lua module in your main program 
```
stepper  = require ('stepper')
```
#### initailization 
initialize the module with necessary variables 
parameters : table with 4 nodemcu pins that are connected to ULN2003, for exmaple, {5,6,7,8} is expected if uln2003 motor driver is connected as mentioned in Connections section. 
```
pins = {5,6,7,8}
stepper.init(pins)
```
#### Rotation 

Once the initalization is done, you can call rotate method like this. On successfull completion of given rotation the callback you passed as a last parameter will be invoked. 
Note : this is a async method. It'll trigger rotation and return immediately. 

##### Signature : 
`rotate( direction, desired_steps, interval, timer_to_use, callback)`

##### Rotation Parameters : 
**direction :** _stepper.FORWARD or stepper.REVERSE_
**desired_steps :**  _number between 0 to infinity - 2500 is default which is roughly half a rotation_ 
**interval :** _time delay in milliseconds between steps, smaller self number is, faster the motor rotates . 5 is default_
**timer_to_use :** _which nodemcu timer to use, 0 is default_
**callback :** _callback to invoke on completion of given rotation
###### Rotation Example  : 
```lua
direction = stepper.FORWARD 
desired_steps = 2500 
interval = 5 
timer_to_use = 0 
stepper.rotate(direction,desired_steps,interval,timer_to_use,function ()
    print('Rotation done. inside callback.')
    -- do some thing useful 
    end)
```
##### Full example 

```
stepper  = require ('stepper')
stepper.init({5,6,7,8})
stepper.rotate(stepper.FORWARD,2500,5,0,function () print('Rotation done.') end)
```
