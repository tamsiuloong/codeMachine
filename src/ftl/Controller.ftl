package ${package}.web.controller.${rootPath};

import ${package}.entity.${className};
import ${package}.service.${className}Service;
import ${package}.utils.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

<#import "CopyRight.ftl" as my>
<@my.CopyRight/>
@RequestMapping("/${rootPath}/${className?uncap_first}")
@RestController
public class ${className}Ctrl {

    @Autowired
    private ${className}Service ${className?uncap_first}Service;

    @GetMapping
    public Pagination list(Pagination page)
    {
        Pagination result = ${className?uncap_first}Service.findByPage(page);
        return result;
    }


    @GetMapping("getAll")
    public List<${className}> getAll(Pagination page)
    {
        List<${className}> ${className?uncap_first}List = ${className?uncap_first}Service.findAll();
        return ${className?uncap_first}List;
    }

    @DeleteMapping
    public String delete(@RequestBody String[] ids)
    {
        ${className?uncap_first}Service.deleteByIds(ids);
        return "1";
    }


    @PutMapping
    public String update(@RequestBody ${className} ${className?uncap_first})
    {
        ${className?uncap_first}Service.update(${className?uncap_first});
        return "1";
    }

    @PostMapping
    public ${className} add(@RequestBody ${className} ${className?uncap_first})
    {
        ${className?uncap_first}Service.save(${className?uncap_first});
        return ${className?uncap_first};
    }
}
