# Filename: test-button.robot
*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      ${RENODEKEYWORDS}

*** Test Cases ***
Button Press should Toggle LED
    Execute Command         mach create
    Execute Command         machine LoadPlatformDescription @${CURDIR}/../nucleo_f446re_custom.repl
    Execute Command         sysbus LoadELF @${CURDIR}/../nucleo-f446re/ButtonLed/build/ButtonLed.elf

    Start Emulation
	
	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal         ${LedState.strip()}    False
	
    Execute Command         sysbus.gpioc.bluebutton Press
    sleep                   100milliseconds
    Execute Command         sysbus.gpioc.bluebutton Release
	
	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal         ${LedState.strip()}    True

    Execute Command         sysbus.gpioc.bluebutton Press
    sleep                   100milliseconds
    Execute Command         sysbus.gpioc.bluebutton Release

	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal         ${LedState.strip()}    False
 