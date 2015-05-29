package com.dianping.periodWeb.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestAction {

    @RequestMapping(value = "test/test")
    public String queryCount() {
        return "test";
    }

}
