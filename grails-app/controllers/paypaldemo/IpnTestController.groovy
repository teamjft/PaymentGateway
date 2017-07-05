package paypaldemo

import grails.plugin.springsecurity.annotation.Secured

@Secured('permitAll')
class IpnTestController {

    def index() {

        println("===============recived IPNs===================================================")
        println(params)
        println("==============request=============================")
        println(request)
        println("=============data end===================================")
    }
}
