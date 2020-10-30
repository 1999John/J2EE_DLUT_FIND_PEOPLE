package Entity;

public class Student implements People {
    private String name;
    private String Id;
    private String phoneNumber;
    private String QQNumber;
    private String mail;
    private String passward;
    public Student(String name,String Id,String phoneNumber,String QQNumber,String mail,String passward) {
        this.name = name;
        this.Id = Id;
        this.phoneNumber = phoneNumber;
        this.QQNumber = QQNumber;
        this.mail = mail;
        this.passward = passward;
    }

    @Override
    public String getName() {
        return this.name;
    }

    @Override
    public String getId() {
        return this.Id;
    }

    @Override
    public String getPhoneNumber() {
        return !this.phoneNumber.equals("nan") ?this.phoneNumber:"";
    }

    @Override
    public String getQQNumber() {
        return !this.QQNumber.equals("nan") ?this.QQNumber:"";
    }

    @Override
    public String getMail() {
        return !this.mail.equals("nan") ?this.mail:"";
    }

    @Override
    public String getPassward() {
        return this.passward;
    }

    @Override
    public void setPassward(String passward) {
        this.passward = passward;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public void setId(String Id) {
        this.Id = Id;
    }

    @Override
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    @Override
    public void setQQNumber(String QQNumber) {
        this.QQNumber = QQNumber;
    }

    @Override
    public void setMail(String mail) {
        this.mail = mail;
    }

    @Override
    public boolean getAttribute() {
        return Config.student;

    }
}
