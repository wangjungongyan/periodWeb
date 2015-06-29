package com.periodWeb.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @RequestMapping(value = "/")
    public ModelAndView listProjects() {

        List<String> projects = new ArrayList<String>();
        projects.add("ly-service");
        projects.add("ly-api");
        projects.add("ly-webmain");

        Map model = new HashMap();
        model.put("projects", projects);

        return new ModelAndView("index", model);
    }

}
