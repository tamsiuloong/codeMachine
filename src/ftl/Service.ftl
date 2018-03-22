package ${package}.service;

import ${package}.entity.${className};
import ${package}.utils.Pagination;

import java.util.List;
<#import "CopyRight.ftl" as my>
<@my.CopyRight/>
public interface ${className}Service {
    Pagination findPage(Pagination pageNo);

    List<${className}> findAll();

    void save(${className} model);

    ${className} findById(String id);

    void update(${className} model);

    void deleteById(String id);
}
