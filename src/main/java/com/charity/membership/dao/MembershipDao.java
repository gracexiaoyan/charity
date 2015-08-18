package com.charity.membership.dao;

import org.springframework.stereotype.Repository;

import com.charity.membership.bean.Membership;

import fi.common.mvc.dao.BaseDAO;

@Repository("membershipDao")
public class MembershipDao extends BaseDAO<Membership> {

}
