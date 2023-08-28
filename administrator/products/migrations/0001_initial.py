# Generated by Django 3.2.20 on 2023-08-01 06:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('administrator', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('description', models.TextField()),
                ('image', models.ImageField(upload_to='product_images/')),
                ('price', models.IntegerField()),
                ('status', models.BooleanField(default=True)),
                ('stock', models.BooleanField(default=True)),
                ('availability', models.IntegerField(choices=[(1, 'Daily'), (2, 'Specific_days')], default=1)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='administrator.category')),
                ('ref_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'products',
            },
        ),
    ]