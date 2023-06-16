using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using CoffeeShop.DB;
using CoffeeShop.Models;

namespace CoffeeShop.Controllers
{
    public class HomeController : Controller
    {

        CoffeeShop2Entities db = new CoffeeShop2Entities();
        public ActionResult Index()
        {
            var coffeeList = db.coffees.Take(6).ToList();
            return View(coffeeList);
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Service()
        {
            return View();
        }

        public ActionResult Menu()
        {
            var coffeeList = db.coffees.ToList();
            return View(coffeeList);
        }

        [HttpPost]
        public ActionResult Menu(int id=0, int id2=0, string Sayi="", string Sayi2="")
        {

            Basket sepet = new Basket();

       

            sepet.IpAddress = Request.UserHostAddress;

            if (Sayi != "" && id > 0)
            {
                sepet.CofeeId = id;
                sepet.number = Convert.ToInt32(Sayi);
            }
            else if (Sayi2 != "" && id2 > 0)
            {
                sepet.CofeeId = id2;
                sepet.number = Convert.ToInt32(Sayi2);
            }

            db.Basket.Add(sepet);
            var saving = db.SaveChanges();
            if (saving > 0)
            {
                return RedirectToAction("SaveBasket");
            }
            else
            {
                return View();
            }

        }

        public ActionResult Contact()
        {
            return View();
        }
        [HttpGet]
        public ActionResult LoginPage()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LoginPage(string mail, string password)
        {
            var user = db.Users.FirstOrDefault(x => x.mail == mail && x.password == password);
           
           if (user.Id == 1)
            {
                Session["OnlineAdmin"] = user;
                Session["OnlineUser"] = user;
                return RedirectToAction("Admin");

            }
            else if(user != null)
            {
                Session["OnlineUser"] = user;
                return RedirectToAction("Index");
            }
            
            else
            {
                return View();
            }

        }

        public ActionResult Admin()
        {
            if (Session["OnlineUser"] == null)
            {
                return RedirectToAction("LoginPage");
            }
            var coffees = db.coffees.ToList();
            return View(coffees);
        }

        public ActionResult DeleteCoffee(int id)
        {
            if (Session["OnlineUser"] == null)
            {
                return RedirectToAction("LoginPage");
            }
            var delete = db.coffees.FirstOrDefault(x => x.Id == id);
            if (delete != null)
            {
                db.coffees.Remove(delete);
                db.SaveChanges();
                return RedirectToAction("Admin");
            }
            else
            {
                return RedirectToAction("Admin");
            }

        }
        public ActionResult DeleteKahve(int id)
        {
            if (Session["OnlineUser"] == null)
            {
                return RedirectToAction("LoginPage");
            }

            var delete = db.Basket.FirstOrDefault(x => x.Id == id);
            if (delete != null)
            {
                db.Basket.Remove(delete);
                db.SaveChanges();
                return RedirectToAction("SaveBasket");
            }
            else
            {
                return RedirectToAction("Admin");
            }

        }
        public ActionResult AddCofee()
        {
            if (Session["OnlineUser"] == null)
            {
                return RedirectToAction("LoginPage");
            }
            return View();
        }
        [HttpPost]
        public ActionResult AddCofee(string name, int price, string description, string type, string image)
        {
            if (Session["OnlineUser"] == null)
            {
                return RedirectToAction("LoginPage");
            }
            coffees addcofee = new coffees();
            addcofee.CofeeName = name;
            addcofee.CofeePrice = price;
            addcofee.CofeeDescription = description;
            if (type == "1")
            {
                addcofee.CoffeeType = true;
            }
            else
            {
                addcofee.CoffeeType = false;
            }

            if (Request.Files != null && Request.Files.Count > 0)
            {
                var file = Request.Files[0];
                if (file.ContentLength > 0)
                {
                    var folder = Server.MapPath("~/images/");
                    var filename = Guid.NewGuid() + ".jpg";
                    file.SaveAs(Path.Combine(folder, filename));
                    var filePath = "images/" + filename;
                    addcofee.CofeeImagePath = filePath;
                }
            }
            db.coffees.Add(addcofee);
            db.SaveChanges();
            return RedirectToAction("AddCofee");
        }
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(string adSoyad, string mail, string sifre)
        {
           
            Users user = new Users();
            user.Fullname = adSoyad;
            user.mail = mail;
            user.password = sifre;
           
            db.Users.Add(user);
            db.SaveChanges();

            return RedirectToAction("LoginPage");
        }

        public ActionResult Logout()
        {
            Session["OnlineAdmin"] = null;
            Session["OnlineUser"] = null;
            return RedirectToAction("LoginPage");

        }

        public ActionResult UpdateCoffee(int id)
        {
            var updatecofee = db.coffees.FirstOrDefault(x => x.Id == id);
            return View(updatecofee);
        }

        [HttpPost]

        public ActionResult UpdateCoffee(string name, int price, string description, string type, string image, int id = 0)
        {
            if (id == 0)
            {
                return RedirectToAction("Admin");
            }
            var update = db.coffees.FirstOrDefault(x => x.Id == id);
            update.CofeeName = name;
            update.CofeePrice = price;
            update.CofeeDescription = description;
            if (type == "1")
            {
                update.CoffeeType = true;
            }
            else
            {
                update.CoffeeType = false;
            }

            if (Request.Files != null && Request.Files.Count > 0)
            {
                var file = Request.Files[0];
                if (file.ContentLength > 0)
                {
                    var folder = Server.MapPath("~/images/");
                    var filename = Guid.NewGuid() + ".jpg";
                    file.SaveAs(Path.Combine(folder, filename));
                    var filePath = "images/" + filename;
                    update.CofeeImagePath = filePath;
                }
            }
            db.SaveChanges();

            return RedirectToAction("Admin");
        }

        int totalPrice = 0;
        public ActionResult SaveBasket()
        {
            var basket = db.Basket.Where(x => x.IpAddress == Request.UserHostAddress).ToList();
            List<coffees> coffeeList = new List<coffees>();
            Dictionary<int, int> quantityDictionary = new Dictionary<int, int>();
            BasketModel basketModel = new BasketModel();
            basketModel.CofeeModel = new List<coffees>();
            basketModel.SepetModel = new List<Basket>();
          

            foreach (var item in basket)
            {
                var cofee = db.coffees.FirstOrDefault(x => x.Id == item.CofeeId);
                basketModel.CofeeModel.Add(cofee);
                basketModel.SepetModel.Add(item);
                coffeeList.Add(cofee);
                int cofeeprice = Convert.ToInt32(cofee.CofeePrice);
                int count = Convert.ToInt32(item.number);
     
                totalPrice = totalPrice + cofeeprice * count;
                ViewBag.tp = totalPrice;
    

            }


           
            return View(basketModel);
        }

        [HttpPost]
        public ActionResult SaveBasket(string name, string address, int totalprice)
        {
            Orders order = new Orders();
            order.OrderCustomerFullName = name;
            order.OrderAddress = address;
            order.OrderDate = DateTime.Today;
            order.OrderTotalPrice = totalprice;
            db.Orders.Add(order);
            db.SaveChanges();
            int lastInsertedId = order.Id;
            var basket = db.Basket.Where(x => x.IpAddress == Request.UserHostAddress).ToList();
            foreach (var item in basket)
            {
                OrderDetail detail = new OrderDetail();
                detail.OrderId = lastInsertedId;
                detail.OrderCofeeId = item.CofeeId;
                db.OrderDetail.Add(detail);
                db.Basket.Remove(item);
                db.SaveChanges();
            }






            return RedirectToAction("Orders");
            //return View();
        }


        public ActionResult Orders()
                                                                                                                                                                                                                                                                                                    {
            var Orders = db.Orders.ToList();
            List<coffees> mylist = new List<coffees>();
           
            foreach (var item in Orders)
            {
                var detail = db.OrderDetail.Where(x => x.OrderId == item.Id).ToList();
                foreach (var detay in detail)
                {
                    var names = db.coffees.FirstOrDefault(x => x.Id == detay.OrderCofeeId);
                    mylist.Add(names);
                }
        
        
            }
            ViewBag.list = mylist;
            return View(Orders);
        }

        

    }
}