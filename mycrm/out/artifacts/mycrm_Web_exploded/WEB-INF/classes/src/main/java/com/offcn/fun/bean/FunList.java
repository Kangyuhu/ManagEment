package com.offcn.fun.bean;

public class FunList extends Function {

    private String modname;
    private String title;
    private String proname;

    public String getModname() {
        return modname;
    }

    public void setModname(String modname) {
        this.modname = modname;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public String getProname() {
        return proname;
    }

    @Override
    public void setProname(String proname) {
        this.proname = proname;
    }
}
