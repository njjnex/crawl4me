package by.njjnex.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "MESSAGE")
public class Message {
	@Id
	@GeneratedValue
	@Column(name = "MESSAGE_ID")
	private long id;
	@Column(name = "DATE")
	private String date;
	@Column(name = "TEXT")
	private String text;
	@Column(name = "AUTHOR")
	private String author;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
		
}
