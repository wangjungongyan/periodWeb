package com.periodWeb.action;

import com.period.client.PeriodClientUtil;
import com.period.common.PeriodEntity;
import com.period.server.PeriodServerUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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

    @RequestMapping(value = "/list/{project}")
    public ModelAndView listProjectEnvs(@PathVariable String project) {
        return listProjectProperties(project, "alpha");
    }

    @RequestMapping(value = "/list/{project}/{selectedEnv}")
    public ModelAndView listProjectProperties(@PathVariable String project, @PathVariable String selectedEnv) {

        Map<String, PeriodEntity> properties = null;
        try {
            properties = PeriodClientUtil.getChildrenProperties(project, selectedEnv);
        } catch (Exception e) {
            properties = new HashMap<String, PeriodEntity>(1);
        }

        List<String> allEnvs = new ArrayList<String>();
        allEnvs.add("alpha");
        allEnvs.add("beta");
        allEnvs.add("pre");

        Map model = new HashMap();
        model.put("properties", properties);
        model.put("selectedEnv", selectedEnv);
        model.put("allEnvs", allEnvs);
        model.put("project", project);

        return new ModelAndView("detail", model);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public boolean updateProperty(@RequestBody String jsonBody) {
        String selectedEnv = "";
        String propertyKey = "";
        String newValue = "";
        String desc = "";
        boolean updated = PeriodServerUtil.updateNode(propertyKey, newValue, desc, selectedEnv);
        return updated;
    }

    @RequestMapping(value = "/delete/{env}/{propertyKey}")
    @ResponseBody
    public boolean deleteProperty(@PathVariable String env, @PathVariable String propertyKey) {
        boolean deleted = PeriodServerUtil.deleteNode(propertyKey, env);
        return deleted;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public boolean addProperty
            (@RequestBody String jsonBody) {
        String env = "";
        String propertyKey = "";
        String value = "";
        String desc = "";
        boolean add = PeriodServerUtil.createPersistentNode(propertyKey, value, desc, env);
        return add;
    }

}
