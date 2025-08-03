using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
namespace accounting
{
    public partial class MainWindow : Window
    {
        public static string Пароль { get; set; }
        public static string Логин { get; set; }
        public static string НазваниеРоли { get; set; }
        public static int a { get; set; }
        DateTime currentTime = DateTime.Now;
        public MainWindow()
        {
            InitializeComponent();
            
        }
        private void submit_Click(object sender, RoutedEventArgs e)
        {
            Логин = log.Text;
            Пароль = pass.Password;
            var user = UchetEntities.GetContext().Пользователи.FirstOrDefault(a => a.Логин == Логин && a.Пароль == Пароль);
            if (user != null)
            {
                var role = UchetEntities.GetContext().Роли.FirstOrDefault(r => r.КодРоли == user.КодРоли);
                if (role != null)
                {
                    НазваниеРоли = role.НазваниеРоли; 
                    Frame mainFrame = this.FindName("MainFrame") as Frame;

                    if (mainFrame != null)
                    {
                        if (role.НазваниеРоли == "Администратор") 
                        {
                            AdminPage adminPage = new AdminPage();
                            this.WindowState = WindowState.Maximized;
                            this.WindowStyle = WindowStyle.SingleBorderWindow;
                            mainFrame.Navigate(adminPage);
                        }
                        else if (role.НазваниеРоли == "Сотрудник") 
                        {
                            EmployePage employeePage = new EmployePage();
                            this.WindowState = WindowState.Maximized;
                            this.WindowStyle = WindowStyle.SingleBorderWindow;
                            mainFrame.Navigate(employeePage);
                        }
                        else
                        {
                            MessageBox.Show("Неизвестная роль: " + role.НазваниеРоли);
                        }
                    }
                    else
                    {
                        MessageBox.Show("Не найден Frame с именем MainFrame.");
                    }
                }
                else
                {
                    MessageBox.Show("Роль пользователя не найдена.");
                }
            }
            else
            {
                MessageBox.Show("Неверный логин или пароль");
            }
            a = user.КодПользователя;
            История история = new История
            {
                КодПользователя=user.КодПользователя, Дата= currentTime, Действие="Вход в систему"
            };
            UchetEntities.GetContext().История.Add(история);
            UchetEntities.GetContext().SaveChanges();
        }

        private void MainFrame_Navigated(object sender, NavigationEventArgs e)
        {

        }
    }
}