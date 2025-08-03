using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Media;

namespace accounting
{
    public partial class AdminPage : Page
    {
        private List<Пользователи> _users;
        private int _selectedCodeUser = 0;
        DateTime currentTime = DateTime.Now;
        public AdminPage()
        {
            InitializeComponent();
            LoadUsers();
            RoleComboBox.Items.Add("Администратор");
            RoleComboBox.Items.Add("Сотрудник");
        }
        private void LoadUsers()
        {
            _users = UchetEntities.GetContext().Пользователи.ToList();
            UsersDataGrid.ItemsSource = _users;
        }
        private void UsersDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (UsersDataGrid.SelectedItem is Пользователи selectedUser)
            {
                FirstNameTextBox.Text = selectedUser.ИмяПользователя;
                LastNameTextBox.Text = selectedUser.ФамилияПользователя;
                LoginTextBox.Text = selectedUser.Логин;
                PasswordTextBox.Text = selectedUser.Пароль;
                EmailTextBox.Text = selectedUser.ЭлектроннаяПочта;
                _selectedCodeUser = selectedUser.КодПользователя;
                
            }
        }
        private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            if (_selectedCodeUser != 0)
            {
                try
                {
                    Пользователи userToUpdate = UchetEntities.GetContext().Пользователи.FirstOrDefault(u => u.КодПользователя == _selectedCodeUser);

                    if (userToUpdate != null)
                    {
                        userToUpdate.ИмяПользователя = FirstNameTextBox.Text;
                        userToUpdate.ФамилияПользователя = LastNameTextBox.Text;
                        userToUpdate.Логин = LoginTextBox.Text;
                        userToUpdate.Пароль = PasswordTextBox.Text;
                        userToUpdate.ЭлектроннаяПочта = EmailTextBox.Text;
                        

                        UchetEntities.GetContext().SaveChanges();

                        LoadUsers();
                        ClearInputFields();
                        _selectedCodeUser = 0;
                    }
                    else
                    {
                        MessageBox.Show("Пользователь для обновления не найден.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при обновлении пользователя: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите пользователя для обновления.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (_selectedCodeUser != 0)
            {
                try
                {
                    Пользователи userToDelete = UchetEntities.GetContext().Пользователи.FirstOrDefault(u => u.КодПользователя == _selectedCodeUser);

                    if (userToDelete != null)
                    {
                        UchetEntities.GetContext().Пользователи.Remove(userToDelete);
                        UchetEntities.GetContext().SaveChanges();

                        LoadUsers();
                        ClearInputFields();
                        _selectedCodeUser = 0;
                    }
                    else
                    {
                        MessageBox.Show("Пользователь для удаления не найден.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при удалении пользователя: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите пользователя для удаления.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            var role = UchetEntities.GetContext().Роли.FirstOrDefault(a => a.НазваниеРоли == RoleComboBox.Text);
            
            try
            {
                Пользователи newUser = new Пользователи
                {
                    ИмяПользователя = FirstNameTextBox.Text,
                    ФамилияПользователя = LastNameTextBox.Text,
                    Логин = LoginTextBox.Text,
                    Пароль = PasswordTextBox.Text,
                    ЭлектроннаяПочта = EmailTextBox.Text,
                    КодРоли = role.КодРоли
                };

                UchetEntities.GetContext().Пользователи.Add(newUser);
                UchetEntities.GetContext().SaveChanges();

                LoadUsers();
                ClearInputFields();
                _selectedCodeUser = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при добавлении пользователя: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        private void ClearInputFields()
        {
            FirstNameTextBox.Text = string.Empty;
            LastNameTextBox.Text = string.Empty;
            LoginTextBox.Text = string.Empty;
            PasswordTextBox.Text = string.Empty;
            EmailTextBox.Text = string.Empty;
            
        }

        private void RoleComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            Window.GetWindow(this)?.Close();
            История история = new История
            {
                КодПользователя = MainWindow.a,
                Дата = currentTime,
                Действие = "Выход из системы"
            };
            UchetEntities.GetContext().История.Add(история);
            UchetEntities.GetContext().SaveChanges();
        }

        private void logButton_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.Navigate(new log());
        }
    }
}