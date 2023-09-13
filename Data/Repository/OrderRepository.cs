using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Models;
using FoodAppApi.Service;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IO.Compression;

namespace FoodAppApi.Data.Repository
{
    public class OrderRepository : IOrderRepository
    {
        private readonly IHubContext<OrderHub> orderHub;
        private readonly DatabaseContext _context;
        private readonly IOrderItemRepository _orderItemRepository;
        private readonly IFeedbackRepository _feedbackRepository;
        private readonly ILoyaltyPointsHistoryRepository _loyaltyPointsHistoryRepository;
        private readonly ICustomerLoyaltyPointsRepository _customerLoyaltyPointsRepository;
        private readonly IRatePointsRepository _ratePointsRepository;
        private readonly IReferralsRepository _referralsRepository;
        private readonly IOrderDocumentsRepository _orderDocumentsRepository;
        public OrderRepository(DatabaseContext context, IOrderItemRepository orderItemRepository, IFeedbackRepository feedbackRepository, ILoyaltyPointsHistoryRepository loyaltyPointsHistoryRepository, 
            ICustomerLoyaltyPointsRepository customerLoyaltyPointsRepository, IRatePointsRepository ratePointsRepository,
            IReferralsRepository referralsRepository, IOrderDocumentsRepository orderDocumentsRepository, IHubContext<OrderHub> _orderHub)
        {
            _context = context;
            _orderItemRepository = orderItemRepository;
            _feedbackRepository = feedbackRepository;
            _feedbackRepository = feedbackRepository;
            _loyaltyPointsHistoryRepository = loyaltyPointsHistoryRepository;
            _customerLoyaltyPointsRepository = customerLoyaltyPointsRepository;
            _ratePointsRepository = ratePointsRepository;
            _referralsRepository = referralsRepository;
            _orderDocumentsRepository = orderDocumentsRepository;
            orderHub = _orderHub;
        }

        public async Task<int> AcceptAddressChange(string orderId, string driverId)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec AcceptAddressChange @OrderId={orderId}, @DriverId={driverId}");
            var records = await _context.Order.Where(record => record.DriverId == driverId && record.IsOngoingOrder != false)
            .ToListAsync();
            await orderHub.Clients.All.SendAsync("ReceiveOrderRecords", records);
            return affectedRows;
        }

        public async Task<int> CheckIfFirstPurchase(string ReferrerId, string customerId)
        {
            var res = await _context.Database.SqlQuery<int>($"exec CheckIfFirstPurchase @ReferrerId={ReferrerId}, @CustomerId={customerId}").ToListAsync();
            return res.FirstOrDefault();
        }

        public async Task<int> CheckIfFirstPurchaseV2(string customerId)
        {
            var res = await _context.Database.SqlQuery<int>($"exec CheckIfFirstPurchaseV2 @CustomerId={customerId}").ToListAsync();
            return res.FirstOrDefault();
        }

        public async Task<int> GetMaxOrderId()
        {
            var res = await _context.Database.SqlQuery<int>($"exec GetMaxOrderId").ToListAsync();
            return res.Count() != 0 ? res[0] : 1;
        }

        public async Task<List<Orders>> GetOngoingOrderByCustomerId(string CustomerId)
        {
            var orderz = await _context.Order.FromSqlInterpolated($"exec GetOngoingOrder {CustomerId}").ToListAsync();
            if(orderz.Count != 0)
            {
                List<Orders> orderList = new List<Orders>();
                foreach(var order in orderz)
                {
                    var ords = new Orders
                    {
                        Id = order.Id,
                        OrderId = order.OrderId,
                        CustomerId = order.CustomerId,
                        DateGmt = order.DateGmt,
                        Address = order.Address,
                        AddressTitle = order.AddressTitle,
                        Shipping = order.Shipping,
                        Discount = order.Discount,
                        Total = order.Total,
                        ModeOfPayment = order.ModeOfPayment,
                        IsOngoingOrder = order.IsOngoingOrder,
                        Status = order.Status,
                        PlacedTime = order.PlacedTime,
                        ProcessingTime = order.ProcessingTime,
                        OnTheWayTime = order.OnTheWayTime,
                        ForPickUpTime = order.ForPickUpTime,
                        DeliveredTime = order.DeliveredTime,
                        CanceledTime = order.CanceledTime,
                        GrandTotal = order.GrandTotal,
                        CreatedAt = order.CreatedAt,
                        UpdatedAt = order.UpdatedAt,
                        Lat = order.Lat,
                        Lon = order.Lon,
                        ReferrerId = order.ReferrerId,
                        OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                        DriverId = order.DriverId,
                        DriverLat = order.DriverLat,
                        DriverLon = order.DriverLon,
                        IsChangeAddress = order.IsChangeAddress,
                        ChangeAddress = order.ChangeAddress,
                        ChangeAddressTitle = order.ChangeAddressTitle,
                        ChangeAddressLat = order.ChangeAddressLat,
                        ChangeAddressLon = order.ChangeAddressLon,
                        AdditionalFee = order.AdditionalFee,
                        IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                        IsArchive = order.IsArchive,
                    };
                    orderList.Add(ords);
                }
               
                return orderList;
            }
            return new List<Orders>();
        }

        public async Task<List<Orders>> GetOngoingOrdersByDriverId(string driverId)
        {
            List<Orders> orderList = new List<Orders>();
            var orderz = await _context.Order.FromSqlInterpolated($"exec GetOngoingOrderByDriverId {driverId}").ToListAsync();
            if (orderz.Count != 0)
            {
                foreach (var order in orderz)
                {
                    var ords = new Orders
                    {
                        Id = order.Id,
                        OrderId = order.OrderId,
                        CustomerId = order.CustomerId,
                        DateGmt = order.DateGmt,
                        Address = order.Address,
                        AddressTitle = order.AddressTitle,
                        Shipping = order.Shipping,
                        Discount = order.Discount,
                        Total = order.Total,
                        ModeOfPayment = order.ModeOfPayment,
                        IsOngoingOrder = order.IsOngoingOrder,
                        Status = order.Status,
                        PlacedTime = order.PlacedTime,
                        ProcessingTime = order.ProcessingTime,
                        OnTheWayTime = order.OnTheWayTime,
                        ForPickUpTime = order.ForPickUpTime,
                        DeliveredTime = order.DeliveredTime,
                        CanceledTime = order.CanceledTime,
                        GrandTotal = order.GrandTotal,
                        CreatedAt = order.CreatedAt,
                        UpdatedAt = order.UpdatedAt,
                        Lat = order.Lat,
                        Lon = order.Lon,
                        ReferrerId = order.ReferrerId,
                        OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                        DriverId = order.DriverId,
                        DriverLat = order.DriverLat,
                        DriverLon = order.DriverLon,
                        IsChangeAddress = order.IsChangeAddress,
                        ChangeAddress = order.ChangeAddress,
                        ChangeAddressTitle = order.ChangeAddressTitle,
                        ChangeAddressLat = order.ChangeAddressLat,
                        ChangeAddressLon = order.ChangeAddressLon,
                        AdditionalFee = order.AdditionalFee,
                        IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                        IsDriverArchive = order.IsDriverArchive
                    };
                    orderList.Add(ords);
                }
            }
            return orderList;
        }

        public async Task<List<Orders>> GetOpenOrders(int lastSyncId)
        {
            var orderz = await _context.Order.FromSqlInterpolated($"exec GetOpenOrderss @LastSyncId={lastSyncId}").ToListAsync();
            if (orderz.Count != 0)
            {
                List<Orders> orderList = new List<Orders>();
                foreach (var order in orderz)
                {
                    var ords = new Orders
                    {
                        Id = order.Id,
                        OrderId = order.OrderId,
                        CustomerId = order.CustomerId,
                        DateGmt = order.DateGmt,
                        Address = order.Address,
                        AddressTitle = order.AddressTitle,
                        Shipping = order.Shipping,
                        Discount = order.Discount,
                        Total = order.Total,
                        ModeOfPayment = order.ModeOfPayment,
                        IsOngoingOrder = order.IsOngoingOrder,
                        Status = order.Status,
                        PlacedTime = order.PlacedTime,
                        ProcessingTime = order.ProcessingTime,
                        OnTheWayTime = order.OnTheWayTime,
                        ForPickUpTime = order.ForPickUpTime,
                        DeliveredTime = order.DeliveredTime,
                        CanceledTime = order.CanceledTime,
                        GrandTotal = order.GrandTotal,
                        CreatedAt = order.CreatedAt,
                        UpdatedAt = order.UpdatedAt,
                        Lat = order.Lat,
                        Lon = order.Lon,
                        ReferrerId = order.ReferrerId,
                        OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                        DriverId = order.DriverId,
                        DriverLat = order.DriverLat,
                        DriverLon = order.DriverLon,
                        IsChangeAddress = order.IsChangeAddress,
                        ChangeAddress = order.ChangeAddress,
                        ChangeAddressTitle = order.ChangeAddressTitle,
                        ChangeAddressLat = order.ChangeAddressLat,
                        ChangeAddressLon = order.ChangeAddressLon,
                        AdditionalFee = order.AdditionalFee,
                        IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                    };
                    orderList.Add(ords);
                }

                return orderList;
            }
            return new List<Orders>();
        }
        public async Task<List<Orders>> GetDeletedOpenOrders(int lastSyncId)
        {
            var orderz = await _context.Order.FromSqlInterpolated($"exec GetClosedOrderss @LastSyncId={lastSyncId}").ToListAsync();
            if (orderz.Count != 0)
            {
                List<Orders> orderList = new List<Orders>();
                foreach (var order in orderz)
                {
                    var ords = new Orders
                    {
                        Id = order.Id,
                        OrderId = order.OrderId,
                        CustomerId = order.CustomerId,
                        DateGmt = order.DateGmt,
                        Address = order.Address,
                        AddressTitle = order.AddressTitle,
                        Shipping = order.Shipping,
                        Discount = order.Discount,
                        Total = order.Total,
                        ModeOfPayment = order.ModeOfPayment,
                        IsOngoingOrder = order.IsOngoingOrder,
                        Status = order.Status,
                        PlacedTime = order.PlacedTime,
                        ProcessingTime = order.ProcessingTime,
                        OnTheWayTime = order.OnTheWayTime,
                        ForPickUpTime = order.ForPickUpTime,
                        DeliveredTime = order.DeliveredTime,
                        CanceledTime = order.CanceledTime,
                        GrandTotal = order.GrandTotal,
                        CreatedAt = order.CreatedAt,
                        UpdatedAt = order.UpdatedAt,
                        Lat = order.Lat,
                        Lon = order.Lon,
                        ReferrerId = order.ReferrerId,
                        OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                        DriverId = order.DriverId,
                        DriverLat = order.DriverLat,
                        DriverLon = order.DriverLon,
                        IsChangeAddress = order.IsChangeAddress,
                        ChangeAddress = order.ChangeAddress,
                        ChangeAddressTitle = order.ChangeAddressTitle,
                        ChangeAddressLat = order.ChangeAddressLat,
                        ChangeAddressLon = order.ChangeAddressLon,
                        AdditionalFee = order.AdditionalFee,
                        IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                    };
                    orderList.Add(ords);
                }

                return orderList;
            }
            return new List<Orders>();
        }
        public async Task<List<Orders>> GetOrderByCustomerId(string CustomerId)
        {
            var orders = await _context.Order.FromSqlInterpolated($"exec GetOrderByCustomerId {CustomerId}").ToListAsync();
            List<Orders> orderList = new List<Orders>();
            foreach (var order in orders)
            {
                var ords = new Orders
                {
                    Id = order.Id,
                    OrderId = order.OrderId,
                    CustomerId = order.CustomerId,
                    DateGmt = order.DateGmt,
                    Address = order.Address,
                    AddressTitle = order.AddressTitle,
                    Shipping = order.Shipping,
                    Discount = order.Discount,
                    Total = order.Total,
                    ModeOfPayment = order.ModeOfPayment,
                    IsOngoingOrder = order.IsOngoingOrder,
                    Status = order.Status,
                    PlacedTime = order.PlacedTime,
                    ProcessingTime = order.ProcessingTime,
                    OnTheWayTime = order.OnTheWayTime,
                    ForPickUpTime = order.ForPickUpTime,
                    DeliveredTime = order.DeliveredTime,
                    CanceledTime = order.CanceledTime,
                    GrandTotal = order.GrandTotal,
                    CreatedAt = order.CreatedAt,
                    UpdatedAt = order.UpdatedAt,
                    Lat = order.Lat,
                    Lon = order.Lon,
                    OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                    FeedBack = await _feedbackRepository.GetFeedbackByOrderId(order.OrderId),
                    DriverId = order.DriverId,
                    DriverLat = order.DriverLat,
                    DriverLon = order.DriverLon,
                    IsChangeAddress = order.IsChangeAddress,
                    ChangeAddress = order.ChangeAddress,
                    ChangeAddressTitle = order.ChangeAddressTitle,
                    ChangeAddressLat = order.ChangeAddressLat,
                    ChangeAddressLon = order.ChangeAddressLon,
                    AdditionalFee = order.AdditionalFee,
                    IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                    IsArchive = order.IsArchive
                };
                orderList.Add(ords);
            }
            return orderList;
        }

        public async Task<Orders> GetOrderDetails(string CustomerId, string OrderId)
        {
            var orders = await _context.Order.FromSqlInterpolated($"exec GetOrderDetails @CustomerId={CustomerId}, @OrderId={OrderId}").ToListAsync();
            var order = orders.FirstOrDefault();
            if(order == null)
            {
                return null;
            }
            var ords = new Orders
            {
                Id = order.Id,
                OrderId = order.OrderId,
                CustomerId = order.CustomerId,
                DateGmt = order.DateGmt,
                Address = order.Address,
                AddressTitle = order.AddressTitle,
                Shipping = order.Shipping,
                Discount = order.Discount,
                Total = order.Total,
                ModeOfPayment = order.ModeOfPayment,
                IsOngoingOrder = order.IsOngoingOrder,
                Status = order.Status,
                PlacedTime = order.PlacedTime,
                ProcessingTime = order.ProcessingTime,
                OnTheWayTime = order.OnTheWayTime,
                ForPickUpTime = order.ForPickUpTime,
                DeliveredTime = order.DeliveredTime,
                CanceledTime = order.CanceledTime,
                GrandTotal = order.GrandTotal,
                CreatedAt = order.CreatedAt,
                UpdatedAt = order.UpdatedAt,
                Lat = order.Lat,
                Lon = order.Lon,
                OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                FeedBack = await _feedbackRepository.GetFeedbackByOrderId(order.OrderId),
                DriverId = order.DriverId,
                DriverLat = order.DriverLat,
                DriverLon = order.DriverLon,
                IsChangeAddress = order.IsChangeAddress,
                ChangeAddress = order.ChangeAddress,
                ChangeAddressTitle = order.ChangeAddressTitle,
                ChangeAddressLat = order.ChangeAddressLat,
                ChangeAddressLon = order.ChangeAddressLon,
                AdditionalFee = order.AdditionalFee,
                IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                IsArchive = order.IsArchive
            };
            return ords;
        }

        public async Task<List<Orders>> GetOrdersByDriverId(string driverId)
        {
            var orders = await _context.Order.FromSqlInterpolated($"exec GetOrdersByDriverId @DriverId={driverId}").ToListAsync();
            List<Orders> orderList = new List<Orders>();
            foreach (var order in orders)
            {
                var ords = new Orders
                {
                    Id = order.Id,
                    OrderId = order.OrderId,
                    CustomerId = order.CustomerId,
                    DateGmt = order.DateGmt,
                    Address = order.Address,
                    AddressTitle = order.AddressTitle,
                    Shipping = order.Shipping,
                    Discount = order.Discount,
                    Total = order.Total,
                    ModeOfPayment = order.ModeOfPayment,
                    IsOngoingOrder = order.IsOngoingOrder,
                    Status = order.Status,
                    PlacedTime = order.PlacedTime,
                    ProcessingTime = order.ProcessingTime,
                    OnTheWayTime = order.OnTheWayTime,
                    ForPickUpTime = order.ForPickUpTime,
                    DeliveredTime = order.DeliveredTime,
                    CanceledTime = order.CanceledTime,
                    GrandTotal = order.GrandTotal,
                    CreatedAt = order.CreatedAt,
                    UpdatedAt = order.UpdatedAt,
                    Lat = order.Lat,
                    Lon = order.Lon,
                    OrderItems = await _orderItemRepository.GetOrderItemByOrderId(order.OrderId),
                    FeedBack = await _feedbackRepository.GetFeedbackByOrderId(order.OrderId),
                    DriverId = order.DriverId,
                    DriverLat = order.DriverLat,
                    DriverLon = order.DriverLon,
                    IsChangeAddress = order.IsChangeAddress,
                    ChangeAddress = order.ChangeAddress,
                    ChangeAddressTitle = order.ChangeAddressTitle,
                    ChangeAddressLat = order.ChangeAddressLat,
                    ChangeAddressLon = order.ChangeAddressLon,
                    AdditionalFee = order.AdditionalFee,
                    IsChangeAddressAccepted = order.IsChangeAddressAccepted,
                    IsDriverArchive = order.IsDriverArchive,
                };
                orderList.Add(ords);
            }
            return orderList;
        }

        public async Task<int> InsertOrder(Orders item, bool isDeductRewards = false)
        {
            
            var referral = await _referralsRepository.CheckForReferrals(item.CustomerId);
            string ReferrerId = null;
            if(referral?.ReferrerId != null)
            {
                ReferrerId = referral.ReferrerId;
            }

            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertOrder @OrderId={item.OrderId}, @CustomerId={item.CustomerId}, @DateGmt={item.DateGmt}, @Address={item.Address}, @AddressTitle={item.AddressTitle}, @Shipping={item.Shipping}, @Discount={item.Discount}, @Total={item.Total}, @ModeOfPayment={item.ModeOfPayment}, @IsOngoingOrder={item.IsOngoingOrder}, @Status={item.Status}, @PlacedTime={item.PlacedTime}, @ProcessingTime={item.ProcessingTime}, @OnTheWayTime={item.OnTheWayTime}, @DeliveredTime={item.DeliveredTime}, @CanceledTime={item.CanceledTime}, @GrandTotal={item.GrandTotal}, @Lat={item.Lat}, @Lon={item.Lon}, @ReferrerId={ReferrerId}");
            var affected = await _orderItemRepository.InsertOrderItem(item.OrderItems);
            var feedback = await _feedbackRepository.InsertFeedback(item.FeedBack);
            var orderdocs = await _orderDocumentsRepository.CreateOrderDocuments(item.OrderId);
            if (item.ModeOfPayment == 2)
            {
                var customerLoyaltyPoints = await _customerLoyaltyPointsRepository.GetActiveLoyaltyPoints(item.CustomerId);
                string referenceId = null;
                try
                {
                    var reff = await _context.Order.Where(x => x.OrderId == item.OrderId).ToListAsync();
                    referenceId = reff.FirstOrDefault().Id.ToString();
                }
                catch (Exception e)
                {

                }
                if (customerLoyaltyPoints?.LoyaltyId != null)
                {
                    var addedBalance = -item.GrandTotal;
                    double remainingPoints = 0;
                    if (isDeductRewards)
                    {
                        var rewardModel = await _referralsRepository.GetReferralReward(item.CustomerId);
                        double initialValue = rewardModel.Balance;
                        if (initialValue < item.GrandTotal)
                        {
                            remainingPoints = Math.Min(customerLoyaltyPoints.Balance, item.GrandTotal - initialValue);
                            Console.WriteLine(remainingPoints);
                            await _referralsRepository.UpdateReferralRewards(item.CustomerId, -initialValue);
                            
                            var modelReferral = new Referrals
                            {
                                Id = 0,
                                CreatedDate = DateTime.Now,
                                OrderId = item.OrderId,
                                Points = -initialValue,
                                ReferralCode = rewardModel.ReferralCode,
                                ReferrerId = rewardModel.ReferralId,
                                ReferenceId = referenceId
                            };
                            await _referralsRepository.InsertReferral(modelReferral);
                        }
                        else
                        {
                            //if referral pay only
                            await _referralsRepository.UpdateReferralRewards(item.CustomerId, addedBalance);

                            var modelReferral = new Referrals
                            {
                                Id = 0,
                                CreatedDate = DateTime.Now,
                                OrderId = item.OrderId,
                                Points = addedBalance,
                                ReferralCode = rewardModel.ReferralCode,
                                ReferrerId = rewardModel.ReferralId,
                                ReferenceId = referenceId
                            };
                            await _referralsRepository.InsertReferral(modelReferral);

                            return (affectedRows == 1 && affected == 1 && feedback == 1) ? 1 : 0;
                        }
                    }
                    remainingPoints = remainingPoints != 0 ? -remainingPoints : addedBalance;
                    var model = new LoyaltyPointsHistory();
                    model.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                    model.OrderId = item.OrderId;
                    model.Id = 0;
                    model.TotalAmount = item.Total;
                    model.AddedBalance = remainingPoints;
                    model.AddedDate = DateTime.Now;
                    model.TransferId = null;
                    model.ActionType = "Order-Purchase";
                    model.Description = $"Deducted {remainingPoints} points to wallet";
                    model.ReferenceId = string.IsNullOrEmpty(referenceId) ? null : Convert.ToInt32(referenceId);

                    var modelLoyalty = new CustomerLoyaltyPoints();
                    modelLoyalty.Id = 0;
                    modelLoyalty.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                    modelLoyalty.CustomerId = customerLoyaltyPoints.CustomerId;
                    modelLoyalty.IsTerminated = customerLoyaltyPoints.IsTerminated;
                    modelLoyalty.TermsAndAgreement = customerLoyaltyPoints.TermsAndAgreement;
                    modelLoyalty.Balance = remainingPoints;

                    var res = await _customerLoyaltyPointsRepository.UpdateLoyaltyBalance(modelLoyalty);
                    if (res > 0)
                    {
                        await _loyaltyPointsHistoryRepository.CreateHistory(model);
                    }
                    
                }
            }
            var result = (affectedRows == 1 && affected == 1 && feedback == 1) ? 1 : 0;
            if(result == 1)
            {
                //List<Orders> orderList = new List<Orders>();
                //orderList = await GetOpenOrders(0);
                //await orderHub.Clients.All.SendAsync("ReceivedOpenOrders", orderList);
            }
            return result;
        }

        public async Task<int> UpdateOrderAddressByOrderId(string orderId, ChangeAddressModel model)
        {
            var exist = _context.Order.Any(x => x.OrderId == orderId && x.IsChangeAddress == false);
            if (!exist)
            {
                return 2;
            }
            var exist2 = _context.Order.Any(x => x.OrderId == orderId && (x.Status == "Placed" || x.Status == "Processing"));
            if (!exist2)
            {
                return 3;
            }
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrderAddressByOrderId @OrderId={orderId}, @ChangeAddress={model.ChangeAddress}, @ChangeAddressTitle={model.ChangeAddressTitle}, @ChangeAddressLat={model.ChangeAddressLat}, @ChangeAddressLon={model.ChangeAddressLon}");
            if (!string.IsNullOrEmpty(model.DriverId))
            {
                var records = await _context.Order.Where(record => record.DriverId == model.DriverId && record.IsOngoingOrder != false)
                .ToListAsync();
                await orderHub.Clients.All.SendAsync("ReceiveOrderRecords", records);
            }

            return affectedRows;
        }

        public async Task<int> UpdateOrderLocationByDriverId(string driverId, string orderId, string Lon, string Lat)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrderSetDriverId @OrderId={orderId}, @DriverId={driverId}, @DriverLat={Lat}, @DriverLon={Lon}");
            return affectedRows;
        }

        public async Task<int> UpdateOrderSetDriverId(string driverId, string orderId, string Lon, string Lat)
        {
            var exist = _context.Order.Any(x => x.OrderId == orderId && x.DriverId != null);
            if (exist)
            {
                return 2;
            }
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrderSetDriverId @OrderId={orderId}, @DriverId={driverId}, @DriverLat={Lat}, @DriverLon={Lon}");
            var existChangeAddres = _context.Order.Any(x => x.OrderId == orderId && x.DriverId == driverId && x.IsChangeAddress == true);
            if(existChangeAddres)
            {
                await AcceptAddressChange(orderId, driverId);
                return affectedRows;
            }

            return affectedRows;
        }

        public async Task<int> UpdateOrderStatus(string OrderId, string OrderStatus)
        {
            if (OrderStatus == "Delivered")
            {
                try
                {
                    var feedback = await _feedbackRepository.GetFeedbackByOrderId(OrderId);
                    if (!string.IsNullOrEmpty(feedback.CustomerId))
                    {
                        var customerLoyaltyPoints = await _customerLoyaltyPointsRepository.GetActiveLoyaltyPoints(feedback.CustomerId);
                        var getOrders = await GetOngoingOrderByCustomerId(feedback.CustomerId);

                        Orders order = new Orders();
                        foreach (var orderz in getOrders)
                        {
                            if (orderz.OrderId == OrderId)
                            {
                                order = orderz;
                                break;
                            }
                        }

                        if (customerLoyaltyPoints?.LoyaltyId != null)
                        {
                            var RatePoints = await _ratePointsRepository.GetRatePoints();
                            var BaseAmount = RatePoints.Rate;
                            
                            
                            var model = new LoyaltyPointsHistory();
                            var addedBalance = Math.Round(order.Total / BaseAmount, 2);
                            model.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                            model.OrderId = OrderId;
                            model.Id = 0;
                            model.TotalAmount = order.Total;
                            model.AddedBalance = addedBalance;
                            model.AddedDate = DateTime.Now;
                            model.TransferId = null;
                            model.ActionType = "Order";
                            model.ReferenceId = order.Id;
                            model.Description = $"Added {addedBalance} points to wallet";

                            var modelLoyalty = new CustomerLoyaltyPoints();
                            modelLoyalty.Id = 0;
                            modelLoyalty.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                            modelLoyalty.CustomerId = customerLoyaltyPoints.CustomerId;
                            modelLoyalty.IsTerminated = customerLoyaltyPoints.IsTerminated;
                            modelLoyalty.TermsAndAgreement = customerLoyaltyPoints.TermsAndAgreement;
                            modelLoyalty.Balance = addedBalance;

                            var res = order.ModeOfPayment != 2 ? await _customerLoyaltyPointsRepository.UpdateLoyaltyBalance(modelLoyalty) : 0;
                            if(res > 0)
                            {
                                await _loyaltyPointsHistoryRepository.CreateHistory(model);
                            }
                        }

                        if (order?.ReferrerId != null)
                        {
                            var IsFirstPurchase = await CheckIfFirstPurchase(order.ReferrerId, order.CustomerId);
                            if (IsFirstPurchase == 0)
                            {
                                await _referralsRepository.updateReferralBalance(order.CustomerId, order.ReferrerId);
                            }
                        }
                    }
                }
                catch(Exception e)
                {
                    Console.WriteLine(e);
                }
            }
            if(OrderStatus == "Cancelled")
            {
                try
                {
                    var feedback = await _feedbackRepository.GetFeedbackByOrderId(OrderId);
                    if (!string.IsNullOrEmpty(feedback.CustomerId))
                    {
                        var customerLoyaltyPoints = await _customerLoyaltyPointsRepository.GetActiveLoyaltyPoints(feedback.CustomerId);
                        if (customerLoyaltyPoints?.LoyaltyId != null)
                        {
                            var RatePoints = await _ratePointsRepository.GetRatePoints();
                            var BaseAmount = RatePoints.Rate;
                            var getOrders = await GetOngoingOrderByCustomerId(feedback.CustomerId);
                            Orders order = new Orders();
                            foreach (var orderz in getOrders)
                            {
                                if (orderz.OrderId == OrderId)
                                {
                                    order = orderz;
                                    break;
                                }
                            }
                            if(order.ModeOfPayment == 2)
                            {
                                var addedBalance = order.GrandTotal;
                                double remainingPoints = 0;
                                var referralOrderId = await _referralsRepository.GetReferralsByOrderId(OrderId);
                                if (referralOrderId?.OrderId != null)
                                {
                                    var rewardModel = await _referralsRepository.GetReferralReward(order.CustomerId);
                                    var initialValue = Math.Abs(Convert.ToDecimal(referralOrderId.Points));

                                    var lyltyHistory = await _loyaltyPointsHistoryRepository.GetHistoryByOrderId(order.OrderId);
                                    if (lyltyHistory?.OrderId != null)
                                        remainingPoints = Math.Abs(lyltyHistory.AddedBalance);

                                    Console.WriteLine(remainingPoints);
                                    await _referralsRepository.UpdateReferralRewards(order.CustomerId, Convert.ToDouble(initialValue));
                                    string referenceId = null;
                                    try
                                    {
                                        var reff = await _context.Order.Where(x => x.OrderId == order.OrderId).ToListAsync();
                                        referenceId = reff.FirstOrDefault().Id.ToString();
                                    }
                                    catch (Exception e)
                                    {

                                    }
                                    var modelReferral = new Referrals
                                    {
                                        Id = 0,
                                        CreatedDate = DateTime.Now,
                                        OrderId = OrderId,
                                        Points = Convert.ToDouble(initialValue),
                                        ReferralCode = rewardModel.ReferralCode,
                                        ReferrerId = rewardModel.ReferralId,
                                        ReferenceId = referenceId,
                                    };
                                    await _referralsRepository.InsertReferral(modelReferral);
                                    //if referral pay only
                                    if (addedBalance == Convert.ToDouble(initialValue))
                                    {
                                        var affectedRows1 = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrder @OrderId={OrderId}, @OrderStatus={OrderStatus}");
                                        return affectedRows1;
                                    }
                                }

                                remainingPoints = remainingPoints != 0 ? remainingPoints : addedBalance;

                                var model = new LoyaltyPointsHistory();
                                model.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                                model.OrderId = OrderId;
                                model.Id = 0;
                                model.TotalAmount = order.Total;
                                model.AddedBalance = remainingPoints;
                                model.AddedDate = DateTime.Now;
                                model.TransferId = null;
                                model.ReferenceId = order.Id;
                                model.ActionType = "Order";
                                model.Description = $"Refunded {remainingPoints} points to wallet";

                                var modelLoyalty = new CustomerLoyaltyPoints();
                                modelLoyalty.Id = 0;
                                modelLoyalty.LoyaltyId = customerLoyaltyPoints.LoyaltyId;
                                modelLoyalty.CustomerId = customerLoyaltyPoints.CustomerId;
                                modelLoyalty.IsTerminated = customerLoyaltyPoints.IsTerminated;
                                modelLoyalty.TermsAndAgreement = customerLoyaltyPoints.TermsAndAgreement;
                                modelLoyalty.Balance = remainingPoints;

                                var res = await _customerLoyaltyPointsRepository.UpdateLoyaltyBalance(modelLoyalty);
                                if (res > 0)
                                {
                                    await _loyaltyPointsHistoryRepository.CreateHistory(model);
                                }
                            }
                        }
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
            }
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrder @OrderId={OrderId}, @OrderStatus={OrderStatus}");
            return affectedRows;
        }

        public async Task<int> ArchiveOrder(string type, string orderid)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec ArchiveOrder @Type={type}, @OrderId={orderid}");
            return affectedRows;
        }
    }
}
