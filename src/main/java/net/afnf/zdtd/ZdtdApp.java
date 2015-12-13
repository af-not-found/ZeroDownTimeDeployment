package net.afnf.zdtd;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
@Controller
public class ZdtdApp {

    //private static Log logger = LogFactory.getLog(ZdtdApp.class);

    public static void main(String[] args) throws Exception {
        SpringApplication.run(ZdtdApp.class, args);
    }

    @Value("${server.port:8080}")
    private String port;

    @Value("${my-version}")
    private String ver;

    @RequestMapping(value = "/")
    @ResponseBody
    public String index() {
        return response(1);
    }

    @RequestMapping(value = "/longWait")
    @ResponseBody
    public String indexLongWait() {
        return response(20000);
    }

    protected String response(long ms) {
        try {
            Thread.sleep(ms);
        }
        catch (InterruptedException e) {
            // do nothing
        }
        return String.format("ver=%s, wait=%dms, port=%s", ver, ms, port);
    }
}
