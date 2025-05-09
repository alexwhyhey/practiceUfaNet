# Generated by Django 5.2 on 2025-04-25 09:52

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100, unique=True)),
                ('logo', models.ImageField(blank=True, null=True, upload_to='categories/%Y/')),
            ],
            options={
                'verbose_name_plural': 'Categories',
                'ordering': ['title'],
            },
        ),
        migrations.CreateModel(
            name='City',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('country', models.CharField(max_length=100)),
                ('region', models.CharField(blank=True, max_length=100)),
            ],
            options={
                'verbose_name_plural': 'Cities',
                'ordering': ['country', 'name'],
            },
        ),
        migrations.CreateModel(
            name='Partner',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=150, unique=True)),
                ('logo', models.ImageField(blank=True, null=True, upload_to='partners/logos/%Y/%m/')),
                ('about', models.TextField(max_length=600)),
            ],
            options={
                'ordering': ['title'],
            },
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50, unique=True)),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Offer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('button_name', models.CharField(max_length=30)),
                ('url', models.URLField()),
                ('what_offer_about', models.TextField(max_length=100)),
                ('where_to_use', models.TextField(max_length=100)),
                ('back_image', models.ImageField(blank=True, null=True, upload_to='offers/background/%Y/')),
                ('how_to_get', models.TextField(max_length=500)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
                ('city', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='offers', to='partners.city')),
                ('partner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='offers', to='partners.partner')),
            ],
        ),
        migrations.CreateModel(
            name='OfferTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('offer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='partners.offer')),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='partners.tag')),
            ],
            options={
                'unique_together': {('offer', 'tag')},
            },
        ),
        migrations.CreateModel(
            name='CategoryTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='partners.category')),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='partners.tag')),
            ],
            options={
                'unique_together': {('category', 'tag')},
            },
        ),
    ]
