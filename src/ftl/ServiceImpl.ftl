package ${package}.service.impl;

import ${package}.dao.BaseDao;
import ${package}.entity.${className};
import ${package}.service.${className}Service;
import ${package}.utils.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

<#import "CopyRight.ftl" as my>
<@my.CopyRight/>
@Transactional
@Service
public class ${className}ServiceImpl implements ${className}Service {
    @Autowired
    private BaseDao<${className},String> ${className?uncap_first}Dao;

    @Override
    public Pagination findPage(Pagination page) {
        return ${className?uncap_first}Dao.pageByHql("from ${className}",page.getPageNo(),page.getPageSize(),null);
    }

    @Override
    public List<${className}> findAll() {
        return ${className?uncap_first}Dao.getListByHQL("from ${className}");
    }

    @Override
    public void save(${className} model) {
        ${className?uncap_first}Dao.save(model);
    }

    @Override
    public void deleteById(String id) {
        ${className?uncap_first}Dao.deleteById(${className}.class,id);
    }

    @Override
    public void update(${className} model) {
        ${className?uncap_first}Dao.update(model);
    }

    @Override
    public ${className} findById(String id) {
        return ${className?uncap_first}Dao.get(${className}.class,id);
    }
}
