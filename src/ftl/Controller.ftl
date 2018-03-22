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
    private ${className}Service deptService;

    @GetMapping
    public Pagination list(Pagination page)
    {
        Pagination result = deptService.findByPage(page);
        return result;
    }


    @GetMapping("getAll")
    public List<${className}> getAll(Pagination page)
    {
        List<${className}> deptList = deptService.findAll();
        return deptList;
    }

    @DeleteMapping
    public String delete(@RequestBody String[] ids)
    {
        deptService.deleteByIds(ids);
        return "1";
    }


    @PutMapping
    public String update(@RequestBody ${className} dept)
    {
        deptService.update(dept);
        return "1";
    }

    @PostMapping
    public ${className} add(@RequestBody ${className} dept)
    {
        deptService.save(dept);
        return dept;
    }
}
