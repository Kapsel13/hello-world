import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.text.SimpleDateFormat;
import java.util.List;

public class FirmaTest extends JFrame implements ActionListener{
 JPanel displayDataInfoPanel;
 JPanel displayButtonPanel;
 JLabel dataInfo;
 JButton displayButton;
 JButton addButton;
 Firma firma;
 JDialog info;
 JTextArea dane;
 JLabel addInfo;
 JPanel addDataInfoPanel;
 JPanel addDataPanel;
 JLabel name;
 JTextField nameText;
 JLabel dateOfBirth;
 JTextField dateOfBirthText;
 JLabel parentOne;
 JTextField parentOneText;
 JLabel parentTwo;
 JTextField parentTwoText;
 JPanel buttonPanel;
 JPanel searchInfoPanel;
 JLabel searchInfo;
 JTextField nameToSearch;
 JButton searchName;
 JTextField dateOfBirthToSearch;
 JButton searchDateOfBirth;
 int id;
 JScrollPane scroll;
 JPanel searchNamePanel;
 JPanel searchDateofBirthPanel;

 public FirmaTest(){
	super("FirmaTest");
       addWindowListener(new WindowAdapter()
        {
         @Override
         public void windowClosing(WindowEvent e)
         {
             firma.closeConnection();
             e.getWindow().dispose();
         }
        });
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setFont((new Font(Font.SANS_SERIF,Font.PLAIN,40)));
        setLayout(new GridLayout(8,1));

        displayDataInfoPanel = new JPanel();
        dataInfo = new JLabel("Press the button to display the content of table dzieci");
        dataInfo.setBorder(BorderFactory.createEmptyBorder(0,50,0,40));

        displayButtonPanel = new JPanel();
        displayButton = new JButton("display");
        displayButton.addActionListener(this);

        addDataInfoPanel = new JPanel();
        addInfo = new JLabel("Bellow complete the form to add new item to table dzieci");
        addInfo.setBorder(BorderFactory.createEmptyBorder(0, 10, 0, 0));

        addDataPanel = new JPanel();
        addDataPanel.setBorder(BorderFactory.createEmptyBorder(0,45,0,40));
        addDataPanel.setLayout(new GridLayout(4,2,10,10));
        name = new JLabel("name");
        nameText= new JTextField();
        dateOfBirth = new JLabel("date_of_birth");
        dateOfBirthText = new JTextField();
        parentOne = new JLabel("parent_one");
        parentOneText = new JTextField();
        parentTwo = new JLabel("parent_two");
        parentTwoText = new JTextField();

        buttonPanel = new JPanel();
        buttonPanel.setBorder(BorderFactory.createEmptyBorder(30,0,0,0));
        addButton = new JButton("add");
        addButton.addActionListener(this);

        searchInfoPanel = new JPanel();
        searchInfo = new JLabel("Bellow you can search child by name or date_of_birth");

        searchNamePanel = new JPanel();
        nameToSearch = new JTextField();
        nameToSearch.setPreferredSize(new Dimension(80,20));
        searchName = new JButton("searchName");
        searchName.addActionListener(this);

        searchDateofBirthPanel = new JPanel();
        dateOfBirthToSearch = new JTextField();
        dateOfBirthToSearch.setPreferredSize(new Dimension(80,20));
        searchDateOfBirth = new JButton("searchDateOfBirth");
        searchDateOfBirth.addActionListener(this);

        displayDataInfoPanel.add(dataInfo);
        displayDataInfoPanel.setBackground(Color.yellow);

        displayButtonPanel.add(displayButton);
        displayButtonPanel.setBackground(Color.yellow);

        addDataInfoPanel.add(addInfo);
        addDataInfoPanel.setBackground(Color.blue);

        addDataPanel.add(name);
        addDataPanel.add(nameText);
        addDataPanel.add(dateOfBirth);
        addDataPanel.add(dateOfBirthText);
        addDataPanel.add(parentOne);
        addDataPanel.add(parentOneText);
        addDataPanel.add(parentTwo);
        addDataPanel.add(parentTwoText);
        addDataPanel.setBackground(Color.blue);

        buttonPanel.add(addButton);
        buttonPanel.setBackground(Color.blue);

        searchInfoPanel.add(searchInfo);
        searchInfoPanel.setBackground(Color.red);

        searchNamePanel.add(nameToSearch);
        searchNamePanel.add(searchName);
        searchNamePanel.setBackground(Color.red);

        searchDateofBirthPanel.add(dateOfBirthToSearch);
        searchDateofBirthPanel.add(searchDateOfBirth);
        searchDateofBirthPanel.setBackground(Color.red);

        add(displayDataInfoPanel);
        add(displayButtonPanel);
        add(addDataInfoPanel);
        add(addDataPanel);
        add(buttonPanel);
        add(searchInfoPanel);
        add(searchNamePanel);
        add(searchDateofBirthPanel);
        pack();
        setVisible(true);
        setResizable(false);
        firma = new Firma();
 }
   public void actionPerformed(ActionEvent e){
        if(e.getActionCommand().equals("display")){
            info=new JDialog(this,"Dane z bazy",true);
            info.setSize(250,250);
            dane = new JTextArea();
            dane.setEditable(false);
            scroll = new JScrollPane(dane);
            scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
            scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
            info.getContentPane().add(scroll);
            List<Dzieci> dzieci = firma.selectDzieci();
            dane.setText(createResultfromDataBase(dzieci));
            info.setVisible(true);
            info.setResizable(false);
        }
        if(e.getActionCommand().equals("add")){
            if(formValidation()) {
                String name = nameText.getText();
                String dateOfBirth = dateOfBirthText.getText();
                int parent_one = Integer.parseInt(parentOneText.getText());
                int parent_two = Integer.parseInt(parentTwoText.getText());
                firma.insertDzieci(name, dateOfBirth, parent_one, parent_two);
            }
        }
        if(e.getActionCommand().equals("searchName")){
            if(searchNameValidation()) {
                String name = nameToSearch.getText();
                info = new JDialog(this, "Dane z bazy", true);
                info.setSize(250, 250);
                dane = new JTextArea();
                dane.setEditable(false);
                scroll = new JScrollPane(dane);
                scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
                scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
                info.getContentPane().add(scroll);
                List<Dzieci> dzieci = firma.selectDzieciByName(name);
                dane.setText(createResultfromDataBase(dzieci));
                info.setVisible(true);
                info.setResizable(false);
            }
        }
       if(e.getActionCommand().equals("searchDateOfBirth")){
           if(searchDateOfBirthValidation()) {
               String dateOfBirth = dateOfBirthToSearch.getText();
               info = new JDialog(this, "Dane z bazy", true);
               info.setSize(250, 250);
               dane = new JTextArea();
               dane.setEditable(false);
               scroll = new JScrollPane(dane);
               scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
               scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
               info.getContentPane().add(scroll);
               List<Dzieci> dzieci = firma.selectDzieciByDateOfBirth(dateOfBirth);
               dane.setText(createResultfromDataBase(dzieci));
               info.setVisible(true);
               info.setResizable(false);
           }
       }
   }
   public String createResultfromDataBase(List<Dzieci> dzieci){
       String text = "";
       id = 0;
       for(int i = 0; i<dzieci.size(); i++){
           id++;
           if((dzieci.get(i).getRodzic1id() == 0)||(dzieci.get(i).getRodzic2id() == 0)){
               if(dzieci.get(i).getRodzic1id() == 0){
                   text=text+id+" "+dzieci.get(i).getImie()+" "+dzieci.get(i).getDataUrodzenia()+" NULL "+dzieci.get(i).getRodzic2id()+"\n";
               }
               else{
                   text=text+id+" "+dzieci.get(i).getImie()+" "+dzieci.get(i).getDataUrodzenia()+" "+dzieci.get(i).getRodzic1id()+" NULL"+"\n";
               }
           }
           else{
               text=text+id+" "+dzieci.get(i).getImie()+" "+dzieci.get(i).getDataUrodzenia()+" "+dzieci.get(i).getRodzic1id()+" "+dzieci.get(i).getRodzic2id()+"\n";
           }
       }
       return text;
   }
   public boolean formValidation(){
       if((nameText.getText().length()==0)||(dateOfBirthText.getText().length()==0)||(parentOneText.getText().length()==0)||(parentTwoText.getText().length()==0)){
           return false;
       }
       String formatedDate;
       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
       try{formatedDate=dateFormat.format(dateFormat.parse(dateOfBirthText.getText()));}
       catch(java.text.ParseException e){
           return false;
       }
       if(!formatedDate.equals(dateOfBirthText.getText())){
        return false;
       }
       String parentOneTextContent = parentOneText.getText();
       boolean validParentOne=true;
       for(int i=0;i<parentOneTextContent.length();i++){
            if(i==0){
                if(((parentOneTextContent.substring(i,i+1).charAt(0))>'9')||((parentOneTextContent.substring(i,i+1).charAt(0))<'1')){
                    validParentOne=false;
                }
            }
            else {
                if (((parentOneTextContent.substring(i, i + 1).charAt(0)) > '9') || ((parentOneTextContent.substring(i, i + 1).charAt(0)) < '0')) {
                    validParentOne = false;
                }
            }
       }
       String parentTwoTextContent = parentTwoText.getText();
       boolean validParentTwo=true;
       for(int i=0;i<parentTwoTextContent.length();i++){
           if(i==0){
               if(((parentTwoTextContent.substring(i,i+1).charAt(0))>'9')||((parentTwoTextContent.substring(i,i+1).charAt(0))<'1')){
                   validParentTwo=false;
               }
           }
           else {
               if (((parentTwoTextContent.substring(i, i + 1).charAt(0)) > '9') || ((parentTwoTextContent.substring(i, i + 1).charAt(0)) < '0')) {
                   validParentTwo = false;
               }
           }
       }
       if((!validParentOne)||(!validParentTwo)){
           return false;
       }
       //validation of name field: name should start with Uppercase and then contains only Lowercase symbols
       String nameTextContent = nameText.getText();
       boolean validName = true;
       for(int i=0;i<nameTextContent.length();i++){
           if(i==0){
               if(((nameTextContent.substring(i,i+1).charAt(0))<65)||((nameTextContent.substring(i,i+1).charAt(0))>90)){
                   validName=false;
               }
           }
           else{
               if(((nameTextContent.substring(i,i+1).charAt(0))<97)||((nameTextContent.substring(i,i+1).charAt(0))>122)){
                   validName=false;
               }
           }
       }
       if(validName==false){
           return false;
       }
       return true;
   }
   public boolean searchNameValidation(){
       if(nameToSearch.getText().length()==0){
            return false;
       }
       //validation of name field: name should start with Uppercase and then contains only Lowercase symbols
       String nameTextContent = nameToSearch.getText();
       boolean validName = true;
       for(int i=0;i<nameTextContent.length();i++){
           if(i==0){
               if(((nameTextContent.substring(i,i+1).charAt(0))<65)||((nameTextContent.substring(i,i+1).charAt(0))>90)){
                   validName=false;
               }
           }
           else{
               if(((nameTextContent.substring(i,i+1).charAt(0))<97)||((nameTextContent.substring(i,i+1).charAt(0))>122)){
                   validName=false;
               }
           }
       }
       if(validName==false){
           return false;
       }
       return true;
   }
   public boolean searchDateOfBirthValidation(){
       if(dateOfBirthToSearch.getText().length()==0){
           return false;
       }
       String formatedDate;
       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
       try{formatedDate=dateFormat.format(dateFormat.parse(dateOfBirthToSearch.getText()));}
       catch(java.text.ParseException e){
           return false;
       }
       if(!formatedDate.equals(dateOfBirthToSearch.getText())) {
           return false;
       }
       return true;
   }
 public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new FirmaTest();
            }
        });

    }
}
