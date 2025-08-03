using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Denemezoo2
{
	public partial class FormBilet : Form
	{
		SqlCommand komut;
		public FormBilet()
		{
			InitializeComponent();
		}
		static string constring = ("Data Source=DESKTOP-OSNDT9I\\SQLEXPRESS;Initial Catalog=Denemezoo2;Integrated Security=True;");
		SqlConnection baglan = new SqlConnection(constring);
		public void Kayitgetirb()
		{
			string getir = "Select * from Bilet";
			SqlCommand komut = new SqlCommand(getir, baglan);
			SqlDataAdapter ad = new SqlDataAdapter(komut);
			DataTable dt = new DataTable();
			ad.Fill(dt);
			DataGrid.DataSource = dt;
			baglan.Close();
		}

		private void btnblistele_Click(object sender, EventArgs e)
		{
			Kayitgetirb();

		}

		private void btnbekle_Click(object sender, EventArgs e)
		{
			try
			{
				if (baglan.State == ConnectionState.Closed)
				{
					baglan.Open();
					string kayit = "INSERT INTO Bilet (biletno,fiyat,gosterinum) VALUES (@no, @fiyat, @gosterinum)";
					SqlCommand komut = new SqlCommand(kayit, baglan);
					komut.Parameters.AddWithValue("@no", txtbno.Text);
					komut.Parameters.AddWithValue("@fiyat", txtbf.Text);
					komut.Parameters.AddWithValue("@gosterinum", txtbgn.Text);
					

					komut.ExecuteNonQuery();

					MessageBox.Show("Kayıt ekleme başarılı");
					Kayitgetirb();
				}

			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);

			}
		
		}

		private void btnbsil_Click(object sender, EventArgs e)
		{
			string sorgu = "DELETE FROM Bilet WHERE biletno=@no";
			komut = new SqlCommand(sorgu, baglan);
			komut.Parameters.AddWithValue("@no", txtbno.Text);
			baglan.Open();
			komut.ExecuteNonQuery();
			baglan.Close();
			Kayitgetirb();
		}

		private void btnbguncelle_Click(object sender, EventArgs e)
		{
			string sorgu = "UPDATE Bilet SET biletno=@no,fiyat=@fiyat,gosterinum=@gosterinum WHERE biletno=@no";
			komut = new SqlCommand(sorgu, baglan);
			komut.Parameters.AddWithValue("@no", txtbno.Text);
			komut.Parameters.AddWithValue("@fiyat", txtbf.Text);
			komut.Parameters.AddWithValue("@gosterinum", txtbgn.Text);
			baglan.Open();
			komut.ExecuteNonQuery();
			baglan.Close();
			Kayitgetirb();
		}

		private void back_Click(object sender, EventArgs e)
		{
			Yonlen Bislem = new Yonlen();
			Bislem.Show();
			this.Hide();
		}
	}
}
