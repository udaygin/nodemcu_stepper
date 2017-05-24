stepper  = require ('stepper')
stepper.init()
desired_steps = 2500
interval = 5
timer_to_use = 0
print('stepper.rotate() - start')
stepper.rotate(stepper.FORWARD,desired_steps,interval,timer_to_use,function ()
    print('Rotation done. inside callback.')
    end)
