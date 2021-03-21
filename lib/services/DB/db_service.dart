
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:winsoft_auth_test_app/models/user.dart';

class DBService {
  DBService._();
  static final DBService db = new DBService._();  
  
  static Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await open();
    return _database;
  }

  String _tableUsers = 'users';
  String _tablePhoneNumbers = 'phone_numbers';
  String _tableAddresses = 'addresses';

  _onConfigure(Database db) async {
  await db.execute("PRAGMA foreign_keys = ON");
}

  open() async {
    return await openDatabase(join(await getDatabasesPath(), 'win_test.db'), onConfigure: _onConfigure, onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableUsers (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT NOT NULL,
          gender TEXT NOT NULL,
          date_of_birth TEXT NOT NULL,
          picture_url TEXT);
          ''');
          await db.execute('''CREATE TABLE $_tablePhoneNumbers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone_number TEXT NOT NULL,
            user_id INTEGER,
            FOREIGN KEY(user_id) REFERENCES $_tableUsers(id));''');
          await db.execute('''CREATE TABLE $_tableAddresses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            address TEXT NOT NULL,
            user_id INTEGER,
            FOREIGN KEY(user_id) REFERENCES $_tableUsers(id));''');
    }, version: 1);
  }

  addUser(User user) async {
    final db = await database;
    var res = await db.rawInsert('''
    INSERT INTO $_tableUsers (first_name, last_name, email, password, gender, date_of_birth, picture_url) VALUES (?, ?, ?, ?, ?, ?, ?)''', [user.firstName, user.lastName, user.email, user.password, user.gender, user.dateOfBirth.toString(), user.pictureUrl]);
    for (var phone in user.phoneNumbers) {
      await db.rawInsert('''
    INSERT INTO $_tablePhoneNumbers (phone_number, user_id) VALUES (?, ?)''', [phone, res]);
    }
    for (var address in user.address) {
      await db.rawInsert('''
    INSERT INTO $_tableAddresses (address, user_id) VALUES (?, ?)''', [address, res]);
    }
    
    return res;
  }

  Future<User> getLogin(String email, String password) async {  
    final db = await database; 
    var res = await db.rawQuery("SELECT * FROM $_tableUsers u INNER JOIN $_tablePhoneNumbers p ON u.id = p.user_id INNER JOIN $_tableAddresses a ON u.id = a.user_id WHERE email = '$email' and password = '$password'");  
      
    if (res.length > 0) {  
      List<String> phones = [];
      List<String> addresses = [];
      for (var d in res) {
        String phoneNumber = d['phone_number'];
        phones.add(phoneNumber);

        String address = d['address'];
        addresses.add(address);
      }
      return User.fromMap(res.first, phones, addresses);
    }  
  
    return null;  
  }

  Future<bool> checkUserExists(String email) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $_tableUsers where email = '$email'");
    return res.isNotEmpty ? true : false;
  }
}