# Filename: test-button.robot
*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      ${RENODEKEYWORDS}

*** Test Cases ***
Should Handle Button Press
    Execute Command         mach create
    Execute Command         machine LoadPlatformDescription @${CURDIR}/../nucleo_f446re_custom.repl
    Execute Command         sysbus LoadELF @${CURDIR}/../nucleo-f446re/ButtonLed/build/ButtonLed.elf

    Start Emulation
	
	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal           ${LedState.strip()}    False
	
    Execute Command         sysbus.gpioc.bluebutton Press
    Execute Command         sysbus.gpioc.bluebutton Release
	
	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal           ${LedState.strip()}    True

    Execute Command         sysbus.gpioc.bluebutton Press
    Execute Command         sysbus.gpioc.bluebutton Release

	${LedState}=  Execute Command  sysbus.gpioa.greenled2 State
	Should Be Equal           ${LedState.strip()}    False
 