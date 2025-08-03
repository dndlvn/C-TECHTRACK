using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Media;
using System.ComponentModel;
using Microsoft.Win32;
using Excel = Microsoft.Office.Interop.Excel;
namespace accounting
{
    public partial class EmployePage : Page
    {
        private List<Оборудование> _equipment;
        private int _selectedEquipmentCode = 0;
        DateTime currentTime = DateTime.Now;
        public static string b;
        public EmployePage()
        {
            InitializeComponent();

            LoadEquipment();

        }
        private void SortComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            swsw();
        }
        private void swsw()
        {
            switch (SortComboBox.SelectedIndex)
            {
                case 0:
                    LoadEquipment();
                    break;
                case 1:
                    NoutLoad();
                    break;
                case 2:
                    ScanerLoad();
                    break;
                case 3:
                    PrinterLoad();
                    break;


            }

        }

        private void LoadEquipment()
        {
            _equipment = UchetEntities.GetContext().Оборудование.ToList();
            EquipmentDataGrid.ItemsSource = _equipment;
        }
        private void ScanerLoad()
        {
            _equipment = UchetEntities.GetContext().Оборудование.Where(a => a.ТипОборудования == "Сканер").ToList();
            EquipmentDataGrid.ItemsSource = _equipment;
        }
        private void NoutLoad()
        {
            _equipment = UchetEntities.GetContext().Оборудование.Where(a => a.ТипОборудования == "Ноутбук").ToList();
            EquipmentDataGrid.ItemsSource = _equipment;
        }
        private void PrinterLoad()
        {
            _equipment = UchetEntities.GetContext().Оборудование.Where(a => a.ТипОборудования == "Принтер").ToList();
            EquipmentDataGrid.ItemsSource = _equipment;
        }

        private void EquipmentDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (EquipmentDataGrid.SelectedItem is Оборудование selectedEquipment)
            {
                НазваниеОборудованияTextBox.Text = selectedEquipment.НазваниеОборудования;
                ТипОборудованияTextBox.Text = selectedEquipment.ТипОборудования;
                СерийныйНомерTextBox.Text = selectedEquipment.СерийныйНомер;
                ДатаПокупкиDatePicker.SelectedDate = selectedEquipment.ДатаПокупки;
                КодСостояниеОборудованияTextBox.Text = selectedEquipment.СостояниеОборудования.Состояние.ToString();
                КодПоставщикаTextBox.Text = selectedEquipment.Поставщики.НазваниеПоставщика.ToString();
                МестоположениеTextBox.Text = selectedEquipment.Местоположение;
                _selectedEquipmentCode = selectedEquipment.КодОборудования;
            }
        }
        private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            if (_selectedEquipmentCode != 0)
            {
                try
                {
                    Оборудование equipmentToUpdate = UchetEntities.GetContext().Оборудование.FirstOrDefault(eq => eq.КодОборудования == _selectedEquipmentCode);
                    if (equipmentToUpdate != null)
                    {
                        equipmentToUpdate.НазваниеОборудования = НазваниеОборудованияTextBox.Text;
                        equipmentToUpdate.ТипОборудования = ТипОборудованияTextBox.Text;
                        equipmentToUpdate.СерийныйНомер = СерийныйНомерTextBox.Text;
                        equipmentToUpdate.ДатаПокупки = ДатаПокупкиDatePicker.SelectedDate;
                        equipmentToUpdate.КодСостояниеОборудования = int.Parse(КодСостояниеОборудованияTextBox.Text);
                        equipmentToUpdate.КодПоставщика = int.Parse(КодПоставщикаTextBox.Text);
                        equipmentToUpdate.Местоположение = МестоположениеTextBox.Text;
                        UchetEntities.GetContext().SaveChanges();

                        LoadEquipment();
                        ClearInputFields();
                        _selectedEquipmentCode = 0;
                    }
                    else
                    {
                        MessageBox.Show("Оборудование для обновления не найдено.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при обновлении оборудования: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите оборудование для обновления.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            История история = new История
            {
                КодПользователя = MainWindow.a,
                Дата = currentTime,
                Действие = "Изменено оборудование"
            };
            UchetEntities.GetContext().История.Add(история);
            UchetEntities.GetContext().SaveChanges();
        }
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (_selectedEquipmentCode != 0)
            {
                try
                {
                    Оборудование equipmentToDelete = UchetEntities.GetContext().Оборудование.FirstOrDefault(eq => eq.КодОборудования == _selectedEquipmentCode);
                    if (equipmentToDelete != null)
                    {
                        UchetEntities.GetContext().Оборудование.Remove(equipmentToDelete);
                        UchetEntities.GetContext().SaveChanges();
                        LoadEquipment();
                        ClearInputFields();
                        _selectedEquipmentCode = 0;
                    }
                    else
                    {
                        MessageBox.Show("Оборудование для удаления не найдено.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при удалении оборудования: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите оборудование для удаления.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            История история = new История
            {
                КодПользователя = MainWindow.a,
                Дата = currentTime,
                Действие = "Удалено оборудование" 
            };
            UchetEntities.GetContext().История.Add(история);
            UchetEntities.GetContext().SaveChanges();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            var status = UchetEntities.GetContext().СостояниеОборудования.FirstOrDefault(a => a.Состояние == КодСостояниеОборудованияTextBox.Text);
            if (status != null)
            {
                var equ = UchetEntities.GetContext().Поставщики.FirstOrDefault(a => a.НазваниеПоставщика == КодПоставщикаTextBox.Text);
                if (equ != null)
                {
                    try
                    {
                        Оборудование newEquipment = new Оборудование
                        {
                            НазваниеОборудования = НазваниеОборудованияTextBox.Text,
                            ТипОборудования = ТипОборудованияTextBox.Text,
                            СерийныйНомер = СерийныйНомерTextBox.Text,
                            ДатаПокупки = ДатаПокупкиDatePicker.SelectedDate,
                            КодСостояниеОборудования = status.Код,
                            КодПоставщика = equ.Код,
                            Местоположение = МестоположениеTextBox.Text,

                        };

                        UchetEntities.GetContext().Оборудование.Add(newEquipment);
                        UchetEntities.GetContext().SaveChanges();
                        LoadEquipment();
                        ClearInputFields();
                        _selectedEquipmentCode = 0;
                        История история = new История
                        {
                            КодПользователя = MainWindow.a,
                            Дата = currentTime,
                            Действие = "Добавлено оборудование:" + НазваниеОборудованияTextBox.Text
                        };
                        UchetEntities.GetContext().История.Add(история);
                        UchetEntities.GetContext().SaveChanges();
                    }

                    catch (Exception ex)
                    {
                        MessageBox.Show($"Ошибка при добавлении оборудования: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
                else
                {
                    MessageBox.Show("Не найдено");
                }
            }
            else
            {
                MessageBox.Show("Не найдено");
            }
        }
        private void ClearInputFields()
        {
            НазваниеОборудованияTextBox.Text = string.Empty;
            ТипОборудованияTextBox.Text = string.Empty;
            СерийныйНомерTextBox.Text = string.Empty;
            ДатаПокупкиDatePicker.SelectedDate = null;
            КодСостояниеОборудованияTextBox.Text = string.Empty;
            КодПоставщикаTextBox.Text = string.Empty;
            МестоположениеTextBox.Text = string.Empty;
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
        private void ExportToExcel_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Excel.Application excelApp = new Excel.Application();

                if (excelApp == null)
                {
                    MessageBox.Show("Не установлен Excel");
                    return;
                }

                Excel.Workbook workbook = excelApp.Workbooks.Add(Type.Missing);
                Excel.Worksheet worksheet = (Excel.Worksheet)workbook.ActiveSheet;
                worksheet.Name = "EquipmentData"; 
                for (int i = 0; i < EquipmentDataGrid.Columns.Count; i++)
                {
                    worksheet.Cells[1, i + 1] = EquipmentDataGrid.Columns[i].Header.ToString();
                }
                for (int i = 0; i < EquipmentDataGrid.Items.Count; i++)
                {
                    for (int j = 0; j < EquipmentDataGrid.Columns.Count; j++)
                    {
                        TextBlock cellContent = EquipmentDataGrid.Columns[j].GetCellContent(EquipmentDataGrid.Items[i]) as TextBlock;
                        if (cellContent != null)
                        {
                            worksheet.Cells[i + 2, j + 1] = cellContent.Text;
                        }
                        else
                        {
                            DataGridColumn column = EquipmentDataGrid.Columns[j];
                            if (column is DataGridTextColumn textColumn && textColumn.Binding is Binding binding)
                            {
                                string bindingPath = binding.Path.Path; 
                                                                        
                                if (!string.IsNullOrEmpty(bindingPath))
                                {
                                    var item = EquipmentDataGrid.Items[i]; 
                                    var propertyInfo = item.GetType().GetProperty(bindingPath); 
                                    if (propertyInfo != null)
                                    {
                                        var value = propertyInfo.GetValue(item, null); 
                                        worksheet.Cells[i + 2, j + 1] = value?.ToString() ?? ""; 
                                    }
                                    else
                                    {
                                        worksheet.Cells[i + 2, j + 1] = ""; 
                                    }
                                }
                                else
                                {
                                    worksheet.Cells[i + 2, j + 1] = ""; 
                                }

                            }
                            else
                            {
                                
                                worksheet.Cells[i + 2, j + 1] = ""; 
                            }
                        }
                    }
                }
                for (int i = 1; i <= EquipmentDataGrid.Columns.Count; i++)
                {
                    worksheet.Columns[i].AutoFit();
                }
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.FileName = "EquipmentData.xlsx";
                saveFileDialog.DefaultExt = ".xlsx";
                saveFileDialog.Filter = "Excel Files|*.xlsx";

                if (saveFileDialog.ShowDialog() == true)
                {
                    workbook.SaveAs(saveFileDialog.FileName, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Excel.XlSaveAsAccessMode.xlNoChange, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
                    excelApp.Quit();
                    MessageBox.Show("Отчет успешно сохранен");
                }
                else
                {
                  
                    workbook.Close(false); 
                    excelApp.Quit();
                }

               
                System.Runtime.InteropServices.Marshal.ReleaseComObject(worksheet);
                System.Runtime.InteropServices.Marshal.ReleaseComObject(workbook);
                System.Runtime.InteropServices.Marshal.ReleaseComObject(excelApp);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка " + ex.Message);
            }
            finally
            {
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

    }
}