import payPalDemo.Role

class BootStrap {

    def init = { servletContext ->


        if(!Role.findByAuthority('consumer')){
            Role role=new Role(authority: 'consumer')
            role.save(flush: true,failOnError: true)
        }
    }
    def destroy = {
    }
}
