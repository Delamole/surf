import UIKit

class ViewController: UIViewController {
    
    //флаг редактирования
    var flag = false

    @IBOutlet weak var collentioSkills: UICollectionView!
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var describeAboutLabel: UILabel!
    
    //задаем начальне значения
    var randomSkills = SKills.getnames()
    
    @IBAction func addSkill(_ sender: Any) {
        
        if (changeButton.currentImage == UIImage(named: "Vector")){
            changeButton.setImage(UIImage(named: "Vector-4"), for: .normal)
            flag = true
            //добавляем + для нового значения
            randomSkills.append(SKills(name: "AddSkill",image: "+"))
            self.collentioSkills.reloadData()
            
        } else if (changeButton.currentImage == UIImage(named: "Vector-4")){
            changeButton.setImage(UIImage(named: "Vector"), for: .normal)
            flag = false
            //удаляем +
            randomSkills.removeLast()
            self.collentioSkills.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        aboutLabel.text = "О себе"
        describeAboutLabel.text = "Experienced software engineer skilled in developing scalable and maintainable systems. Experienced software engineer skilled in developing scalable and maintainable systems. Experienced software engineer skilled in developing scalable and maintainable systems. Experienced software engineer skilled in developing scalable and maintainable systems"
        describeAboutLabel.lineBreakMode = .byClipping
        changeButton.setImage(UIImage(named: "Vector"), for: .normal)
        //обновляем коллекцию
        collentioSkills.reloadData()
        super.viewDidLoad()
    }
}
//расширеям класс методами для коллекции
extension ViewController: UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return randomSkills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionViewCell", for: indexPath) as! SkillCollectionViewCell
      //скрываем или показываем редактирование навыков
        if (flag == true){
            cell.deleteSkill.isHidden = false
            cell.deleteSkill.addTarget(self, action: #selector(changeSkill), for: .touchUpInside)
        } else {
            cell.deleteSkill.isHidden = true
        }
        
        if (randomSkills[indexPath.row].name == "AddSkill"){
            cell.nameSkill.isHidden = true
        } else {
            cell.nameSkill.isHidden = false
        }
        if(cell.nameSkill.frame.size.width > 50){
            let name = randomSkills[indexPath.row].name.take(10) + "..."
            cell.nameSkill.text = name
        } else {
            cell.nameSkill.text=randomSkills[indexPath.row].name
        }
        cell.deleteSkill.setTitle(randomSkills[indexPath.row].image, for: .normal)
        cell.deleteSkill.setTitleColor(.black, for: .normal)
        cell.deleteSkill.titleLabel?.font = .systemFont(ofSize: 8.0, weight: .medium)
        cell.deleteSkill.tag = indexPath.row
        cell.contentView.backgroundColor = .systemGray6
        cell.contentView.layer.cornerRadius = 10

        return cell
    }
    
    @objc func changeSkill(sender: UIButton)
    {//добавляем новый
        if (sender.tag == randomSkills.count-1 && randomSkills[sender.tag].name == "AddSkill"){
            let alert = UIAlertController(title: "Добавление навыка",
                 message: "Введите название навыка которым вы владеете",
                 preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Отмена",
              style: .cancel) { (action: UIAlertAction!) -> Void in
                self.collentioSkills.reloadData()
            }
            
             let saveAction = UIAlertAction(title: "Добавить",
                                            style: .default) { (action: UIAlertAction!) -> Void in
            
                let textField = alert.textFields![0]
                 textField.placeholder = "Введите название"
                 if (textField.text==""){
                     self.collentioSkills.reloadData()
                     return
                 } else {
                     self.randomSkills.insert(SKills(name: textField.text ?? "", image: "x") , at: self.randomSkills.count-1)
                     self.collentioSkills.reloadData()
                 }
             }
            
            alert.addTextField {
               (textField: UITextField!) -> Void in
            }
            
             alert.addAction(cancelAction)
             alert.addAction(saveAction)
            alert.preferredAction = saveAction
            present(alert, animated: true, completion: nil)
        }else{
            //иначе удаляем
            randomSkills.remove(at: sender.tag)
            collentioSkills.reloadData()
        }
    }
}
