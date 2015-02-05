package by.njjnex.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class DomRule {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;
	@Column(name="RULE_NUMBER")
	private int ruleNumber;
	@Column(name="RULE_NAME")
	private String key;
	@Column(name = "RULE_VALUE")
	private String value;
		
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public int getRuleNumber() {
		return ruleNumber;
	}
	public void setRuleNumber(int ruleNumber) {
		this.ruleNumber = ruleNumber;
	}
		
}
