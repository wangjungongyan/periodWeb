package com.periodWeb.action;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.period.client.PeriodClientUtil;
import com.period.common.PeriodEntity;
import com.period.server.PeriodServerUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PropertyOperateController {

    @RequestMapping(value = "/list/{project}", method = RequestMethod.GET)
    public ModelAndView listProjectEnvs(@PathVariable String project) {
        return listProjectProperties(project, "alpha");
    }

    @RequestMapping(value = "/list/{project}/{selectedEnv}", method = RequestMethod.GET)
    public ModelAndView listProjectProperties(@PathVariable String project, @PathVariable String selectedEnv) {

        Map<String, PeriodEntity> properties = null;
        try {
            properties = PeriodClientUtil.getChildrenProperties(project, selectedEnv);
        } catch (Exception e) {
            properties = new HashMap<String, PeriodEntity>(1);
        }

        Map model = new HashMap();
        model.put("properties", properties);
        model.put("selectedEnv", selectedEnv);
        model.put("allEnvs", getAllEnvs());
        model.put("project", project);

        return new ModelAndView("detail", model);
    }

    @RequestMapping(value = "/property", method = RequestMethod.PUT)
    @ResponseBody
    public boolean updateProperty(@RequestBody String jsonBody) {

        JSONObject ob = parse2JsonObject(jsonBody);
        String selectedEnv = (String) ob.get("env");
        String propertyKey = (String) ob.get("editKey");
        String newValue = (String) ob.get("editValue");
        String desc = (String) ob.get("editDesc");

        return PeriodServerUtil.updateNode(propertyKey, newValue, desc, selectedEnv);
    }

    @RequestMapping(value = "/property", method = RequestMethod.DELETE)
    @ResponseBody
    public boolean deleteProperty(@RequestBody String jsonBody) {

        JSONObject parma = parse2JsonObject(jsonBody);
        String env = parma.getString("env");
        String propertyKey = parma.getString("deleteKey");

        return PeriodServerUtil.deleteNode(propertyKey, env);
    }

    @RequestMapping(value = "/property", method = RequestMethod.POST)
    @ResponseBody
    public boolean addProperty
            (@RequestBody String jsonBody) {

        JSONObject param = parse2JsonObject(jsonBody);
        String envs = param.getString("envs");
        String propertyKey = param.getString("addKey");
        String value = param.getString("addValue");
        String desc = param.getString("addDesc");

        String envArr[] = envs.split("\\,");

        boolean result = true;

        for (String env : envArr) {
            boolean add = PeriodServerUtil.createPersistentNode(propertyKey, value, desc, env);
            if (!add) {
                result = false;
            }
        }

        return result;

    }

    private JSONObject parse2JsonObject(String jsonBody) {

        JSONObject ob = null;
        try {
            ob = JSON.parseObject(URLDecoder.decode(jsonBody, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            ob = null;
        }

        return ob;
    }

    private List<String> getAllEnvs() {

        List<String> allEnvs = new ArrayList<String>();

        allEnvs.add("alpha");
        allEnvs.add("beta");
        allEnvs.add("pre");

        return allEnvs;
    }

}
